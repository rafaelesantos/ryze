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
            logger.error(.invalidURL(String(describing: request)))
            throw RyzeNetworkError.invalidURL
        }
        
        let port = try endpoint.port.rawValue
        logger.info(.connecting(endpoint.host.debugDescription, "\(port)", endpoint.parameters.debugDescription))
        
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
                        logger.info(.connectionEstablished(endpoint.host.debugDescription, "\(port)"))
                        await receive(on: continuation)
                    case .close:
                        logger.info(.connectionClosed(endpoint.host.debugDescription, "\(port)"))
                        continuation.finish()
                    }
                }
                
                continuation.onTermination = { [weak self] _ in
                    guard let self else { return }
                    Task {
                        await self.disconnect()
                        logger.info(.disconnected(endpoint.host.debugDescription, "\(port)"))
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
                    logger.info(.connectionReady)
                    continuation.yield(.open)
                case .cancelled:
                    logger.warning(.connectionCancelled)
                    continuation.yield(.close)
                case .failed(let error):
                    logger.error(.connectionFailed(error.localizedDescription))
                    continuation.yield(.close)
                default:
                    logger.info(.connectionStateChanged(String(describing: state)))
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
    
    private func receive(on continuation: AsyncStream<String>.Continuation) async {
        connection?.receive(
            minimumIncompleteLength: 1,
            maximumLength: 65536
        ) { [weak self] content, contentContext, isComplete, error in
            let logger = RyzeNetworkLogger()
            if let error = error {
                logger.error(.receiveError(error.localizedDescription))
            }
            
            if let data = content, let value = String(data: data, encoding: .utf8) {
                continuation.yield(value)
            }
            
            if isComplete {
                logger.info(.receptionComplete)
                continuation.finish()
            }
            
            Task(priority: .high) { await self?.receive(on: continuation) }
        }
    }
    
    public func send(command: RyzeNetworkSocketCommand) async throws {
        let logger = RyzeNetworkLogger()
        guard let content = command.message.breakLine.data(using: .utf8) else {
            logger.error(.failedToEncode(command.message))
            throw RyzeNetworkError.badRequest
        }
        
        logger.info(.sendingMessage(command.message))
        
        try await withCheckedThrowingContinuation { continuation in
            connection?.send(
                content: content,
                completion: .contentProcessed { error in
                    guard let error else {
                        logger.info(.messageSent(command.message))
                        return continuation.resume()
                    }
                    logger.error(.sendError(error.localizedDescription))
                }
            )
        }
    }
    
    private func disconnect() {
        connection?.cancel()
    }
}
