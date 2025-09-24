//
//  RyzeSystemMonitorModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/09/25.
//

import SwiftUI

public struct RyzeSystemMonitor: Sendable {
    public var cpuPercentageUsage: Double
    public var cpuTotalPercentage: Double
    public var cpuUsage: Int
    public var cpuCores: Int
    
    public var memoryPercentageUsage: Double
    public var memoryTotalPercentage: Double
    public var memoryUsed: String
    public var memoryTotal: String
    
    public init(
        cpuPercentageUsage: Double = .zero,
        cpuTotalPercentage: Double = .zero,
        cpuUsage: Int = .zero,
        cpuCores: Int = .zero,
        memoryPercentageUsage: Double = .zero,
        memoryTotalPercentage: Double = .zero,
        memoryUsed: String = "",
        memoryTotal: String = ""
    ) {
        self.cpuPercentageUsage = cpuPercentageUsage
        self.cpuTotalPercentage = cpuTotalPercentage
        self.cpuUsage = cpuUsage
        self.cpuCores = cpuCores
        self.memoryPercentageUsage = memoryPercentageUsage
        self.memoryTotalPercentage = memoryTotalPercentage
        self.memoryUsed = memoryUsed
        self.memoryTotal = memoryTotal
    }
}

struct RyzeSystemMonitorModifier: ViewModifier {
    @State var previousCpuInfo: host_cpu_load_info?
    @Binding var systemMonitor: RyzeSystemMonitor
    
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    init(systemMonitor: Binding<RyzeSystemMonitor>) {
        self._systemMonitor = systemMonitor
    }
    
    func body(content: Content) -> some View {
        content
            .onReceive(timer) { _ in
                Task {
                    guard let cpu = getAppCPUUsage(),
                          let memory = getMemoryUsage()
                    else { return }
                    
                    withAnimation(.bouncy) { @MainActor in
                        systemMonitor = RyzeSystemMonitor(
                            cpuPercentageUsage: cpu.cpuPercentageUsage,
                            cpuTotalPercentage: cpu.cpuTotalPercentage,
                            cpuUsage: cpu.cpuUsage,
                            cpuCores: cpu.cpuCores,
                            memoryPercentageUsage: memory.memoryPercentageUsage,
                            memoryTotalPercentage: memory.memoryTotalPercentage,
                            memoryUsed: memory.memoryUsed,
                            memoryTotal: memory.memoryTotal
                        )
                    }
                }
            }
    }
    
    func getAppCPUUsage() -> (
        cpuPercentageUsage: Double,
        cpuTotalPercentage: Double,
        cpuUsage: Int,
        cpuCores: Int
    )? {
        var totalUsageOfCPU: Double = .zero
        var threadsList: thread_act_array_t?
        var threadsCount = mach_msg_type_number_t(0)
        
        let threadsResult = task_threads(mach_task_self_, &threadsList, &threadsCount)
        
        guard threadsResult == KERN_SUCCESS else { return nil }
        
        for index in .zero ..< threadsCount {
            var threadInfo = thread_basic_info()
            var threadInfoCount = mach_msg_type_number_t(THREAD_INFO_MAX)
            
            let infoResult = withUnsafeMutablePointer(to: &threadInfo) {
                $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                    thread_info(
                        threadsList![Int(index)],
                        thread_flavor_t(THREAD_BASIC_INFO),
                        $0,
                        &threadInfoCount
                    )
                }
            }
            
            guard infoResult == KERN_SUCCESS else { continue }
            
            let threadBasicInfo = threadInfo as thread_basic_info
            if threadBasicInfo.flags & TH_FLAGS_IDLE == .zero {
                let threadUsage = (Double(threadBasicInfo.cpu_usage) / Double(TH_USAGE_SCALE))
                totalUsageOfCPU += threadUsage
            }
        }
        
        vm_deallocate(
            mach_task_self_,
            vm_address_t(UInt(bitPattern: threadsList)),
            vm_size_t(Int(threadsCount) * MemoryLayout<thread_t>.stride)
        )
        
        let cpuCores = ProcessInfo.processInfo.activeProcessorCount
        let adjustedUsage = totalUsageOfCPU * cpuCores.double
        let cpuTotalPercentage = cpuCores.double
        let cpuPercentageUsage = adjustedUsage / cpuTotalPercentage
        let cpuUsage = adjustedUsage.rounded().int
        
        return (cpuPercentageUsage, cpuTotalPercentage, cpuUsage, cpuCores)
    }
    
    func getMemoryUsage() -> (
        memoryPercentageUsage: Double,
        memoryTotalPercentage: Double,
        memoryUsed: String,
        memoryTotal: String
    )? {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(
                    mach_task_self_,
                    task_flavor_t(MACH_TASK_BASIC_INFO),
                    $0,
                    &count
                )
            }
        }
        
        guard kerr == KERN_SUCCESS else { return nil }
        
        let usageBytes = Int64(info.resident_size)
        let totalMemoryBytes = Int64(ProcessInfo.processInfo.physicalMemory)
        
        guard totalMemoryBytes > .zero else { return nil }
        
        let memoryUsed = formatBytes(usageBytes)
        let memoryTotal = formatBytes(totalMemoryBytes)
        
        let memoryPercentageUsage = Double(usageBytes) / Double(totalMemoryBytes)
        
        return (memoryPercentageUsage, 1, memoryUsed, memoryTotal)
    }
    
    func formatBytes(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .memory
        return formatter.string(fromByteCount: bytes)
    }
}
