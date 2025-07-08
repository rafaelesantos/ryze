//
//  RyzeNetworkSocketClient.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

@_exported import Foundation
@_exported import RyzeFoundation

public protocol RyzeNetworkSocketClient: Sendable {
    func send(command: RyzeNetworkSocketCommand) async throws
    func connect<Request: RyzeNetworkSocketRequest>(with request: Request) async throws -> AsyncStream<String>
}
