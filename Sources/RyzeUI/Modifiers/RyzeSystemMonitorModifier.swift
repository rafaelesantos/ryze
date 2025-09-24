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
            .onAppear { previousCpuInfo = hostCPULoadInfo() }
            .onReceive(timer) { _ in
                Task {
                    guard let cpu = getCPUUsage(),
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
    
    func hostCPULoadInfo() -> host_cpu_load_info? {
        let HOST_CPU_LOAD_INFO_COUNT = MemoryLayout<host_cpu_load_info>.stride/MemoryLayout<integer_t>.stride
        var size = mach_msg_type_number_t(HOST_CPU_LOAD_INFO_COUNT)
        var cpuLoadInfo = host_cpu_load_info()

        let result = withUnsafeMutablePointer(to: &cpuLoadInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: HOST_CPU_LOAD_INFO_COUNT) {
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
            }
        }
        
        if result != KERN_SUCCESS { return nil }
        return cpuLoadInfo
    }
    
    func getCPUUsage() -> (
        cpuPercentageUsage: Double,
        cpuTotalPercentage: Double,
        cpuUsage: Int,
        cpuCores: Int
    )? {
        guard let currentInfo = hostCPULoadInfo(),
              let previousInfo = previousCpuInfo
        else { return nil }
        
        let userDiff = currentInfo.cpu_ticks.0 - previousInfo.cpu_ticks.0
        let systemDiff = currentInfo.cpu_ticks.1 - previousInfo.cpu_ticks.1
        let idleDiff = currentInfo.cpu_ticks.2 - previousInfo.cpu_ticks.2
        let niceDiff = currentInfo.cpu_ticks.3 - previousInfo.cpu_ticks.3
        
        let totalTicks = userDiff + systemDiff + idleDiff + niceDiff
        let usedTicks = userDiff + systemDiff + niceDiff
        
        previousCpuInfo = currentInfo
        
        guard totalTicks > .zero else { return nil }
        
        let relativeCPU = Double(usedTicks) / Double(totalTicks)
        let cpuCores = ProcessInfo.processInfo.activeProcessorCount
        let cpuTotalPercentage = Double(cpuCores)
        let cpuPercentageUsage = relativeCPU * cpuTotalPercentage
        let cpuUsage = Int(cpuPercentageUsage)
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
