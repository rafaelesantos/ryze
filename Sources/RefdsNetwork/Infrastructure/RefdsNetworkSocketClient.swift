//
//  RefdsNetworkSocketClient.swift
//  Refds
//
//  Created by Rafael Escaleira on 15/05/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

public protocol RefdsNetworkSocketClient: Sendable {
    func send(message: String) async throws
    func connect<Request: RefdsNetworkSocketRequest>(with request: Request) async throws -> AsyncThrowingStream<String, Error>
}
