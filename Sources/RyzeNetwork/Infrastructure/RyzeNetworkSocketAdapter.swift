//
//  RyzeNetworkSocketAdapter.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

import Network
import Foundation
import RyzeFoundation

public actor RyzeNetworkSocketAdapter: RyzeNetworkSocketClient {
    private var connection: NWConnection?
    
    public init() {}
    
    public func connect<Request: RyzeNetworkSocketRequest>(with request: Request) async throws -> AsyncStream<String> {
        let logger = RyzeNetworkLogger()
        guard let endpoint = await request.endpoint else {
            logger.error("❌ Invalid URL for request: \(String(describing: request))")
            throw RyzeNetworkError.invalidURL
        }
        
        let port = try endpoint.port.rawValue
        logger.info("🌐 Connecting to host \(endpoint.host) on port \(port) with parameters: \(endpoint.parameters)")
        
        connection = try NWConnection(
            host: endpoint.host,
            port: endpoint.port,
            using: endpoint.parameters
        )
        
        return AsyncStream { continuation in
            Task(priority: .high) {
                let stream = await connect()
                for await status in stream {
                    switch status {
                    case .open:
                        logger.info("✅ Connected to \(endpoint.host) on port \(port)")
                        receive(on: continuation)
                    case .close:
                        logger.info("🔌 Connection closed to \(endpoint.host) on port \(port)")
                        continuation.finish()
                    }
                }
                
                continuation.onTermination = { [weak self] _ in
                    guard let self else { return }
                    Task {
                        await self.disconnect()
                        logger.info("👋 Disconnected from \(endpoint.host) on port \(port)")
                    }
                }
            }
        }
    }
    
    private func connect() async -> AsyncStream<RyzeNetworkSocketStatus> {
        AsyncStream { continuation in
            connection?.stateUpdateHandler = { state in
                let logger = RyzeNetworkLogger()
                switch state {
                case .ready:
                    logger.info("🟢 Connection ready!")
                    continuation.yield(.open)
                case .cancelled:
                    logger.info("⚠️ Connection cancelled.")
                    continuation.yield(.close)
                case .failed(let error):
                    logger.error("❗️Connection failed: \(error.localizedDescription)")
                    continuation.yield(.close)
                default:
                    logger.info("🔄 Connection state changed: \(String(describing: state))")
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
    
    private func receive(on continuation: AsyncStream<String>.Continuation) {
        connection?.receiveMessage { [weak self] content, contentContext, isComplete, error in
            let logger = RyzeNetworkLogger()
            if let error = error {
                logger.error("📭 Receive error: \(error.localizedDescription)")
            }
            
            if let data = content, let value = String(data: data, encoding: .utf8) {
                continuation.yield(value)
            }
            
            if isComplete {
                logger.info("📬 Reception complete.")
                continuation.finish()
            }
            
            self?.receive(on: continuation)
        }
    }
    
    public func send(command: RyzeNetworkSocketCommand) async throws {
        let logger = RyzeNetworkLogger()
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
                        logger.info("✅ Message sent: \(command.message)")
                        return continuation.resume()
                    }
                    logger.error("🚫 Send error: \(error.localizedDescription)")
                }
            )
        }
    }
    
    private func disconnect() {
        connection?.cancel()
    }
}
