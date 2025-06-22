//
//  RyzeNetworkSocketAdapter.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

import Network
import Foundation
import RyzeFoundation
import RyzeDependency

actor RyzeNetworkSocketAdapter: RyzeNetworkSocketClient {
    private var connection: NWConnection?
    
    nonisolated private var logger: Logger {
        Logger(
            subsystem: Bundle.module.bundleIdentifier ?? String(describing: self),
            category: String(describing: self)
        )
    }
    
    init() {}
    
    func connect<Request: RyzeNetworkSocketRequest>(with request: Request) async throws -> AsyncThrowingStream<String, Error> {
        guard let endpoint = await request.endpoint else {
            logger.error("❌ Invalid URL for request: \(String(describing: request))")
            throw RyzeNetworkError.invalidURL
        }
        
        let port = try endpoint.port.rawValue
        logger.info("🔗 Connecting to \(endpoint.host.debugDescription):\(port) using parameters: \(endpoint.parameters.debugDescription)")
        
        connection = try NWConnection(
            host: endpoint.host,
            port: endpoint.port,
            using: endpoint.parameters
        )
        
        return AsyncThrowingStream { continuation in
            Task(priority: .high) {
                let stream = try await connect()
                for await status in stream {
                    switch status {
                    case .open:
                        logger.info("✅ Connection established to \(endpoint.host.debugDescription):\(port)")
                        await receive(on: continuation)
                    case .close:
                        logger.info("🔌 Connection closed to \(endpoint.host.debugDescription):\(port)")
                        continuation.finish()
                    }
                }
                
                continuation.onTermination = { [weak self] _ in
                    guard let self else { return }
                    Task {
                        await self.disconnect()
                        self.logger.info("🔌 Disconnected from \(endpoint.host.debugDescription):\(port)")
                    }
                }
            }
        }
    }
    
    private func connect() async throws -> AsyncStream<RyzeNetworkSocketStatus> {
        AsyncStream { continuation in
            connection?.stateUpdateHandler = { state in
                switch state {
                case .ready:
                    self.logger.info("✅ Connection ready")
                    continuation.yield(.open)
                case .cancelled:
                    self.logger.warning("🚫 Connection cancelled")
                    continuation.yield(.close)
                case .failed(let error):
                    self.logger.error("⚠️ Connection failed with error: \(error)")
                    continuation.yield(.close)
                default:
                    self.logger.debug("🔄 Connection state changed: \(String(describing: state))")
                    break
                }
            }
            connection?.start(
                queue: DispatchQueue(
                    label: UUID().uuidString,
                    qos: .userInitiated,
                    attributes: .concurrent
                )
            )
        }
    }
    
    private func receive(on continuation: AsyncThrowingStream<String, Error>.Continuation) async {
        connection?.receive(
            minimumIncompleteLength: 1,
            maximumLength: 65536
        ) { [weak self] content, contentContext, isComplete, error in
            guard let self else { return }
            
            if let error = error {
                self.logger.error("⚠️ Error while receiving data: \(error)")
                return continuation.finish(throwing: error)
            }
            
            if let data = content, let value = String(data: data, encoding: .utf8) {
                self.logger.info("📩 Message received: \(value)")
                continuation.yield(value)
            }
            
            if isComplete {
                self.logger.info("🔚 Data reception complete")
                return continuation.finish()
            }
            
            Task(priority: .high) { await self.receive(on: continuation) }
        }
    }
    
    func send(command: RyzeNetworkSocketCommand) async throws {
        guard let content = command.message.breakLine.data(using: .utf8) else {
            logger.error("❌ Failed to encode message: \(command.message)")
            throw RyzeNetworkError.badRequest
        }
        
        logger.info("✉️ Sending message: \(command.message)")
        
        try await withCheckedThrowingContinuation { continuation in
            connection?.send(
                content: content,
                completion: .contentProcessed { error in
                    guard let error else {
                        self.logger.info("✅ Message sent successfully: \(command.message)")
                        return continuation.resume()
                    }
                    self.logger.error("⚠️ Error while sending message: \(error.localizedDescription)")
                }
            )
        }
    }
    
    private func disconnect() {
        connection?.cancel()
    }
    
    static func registerDependency() async throws {
        try RyzeDependency.register(for: RyzeNetworkSocketClient.self) {
            RyzeNetworkSocketAdapter()
        }
    }
}
