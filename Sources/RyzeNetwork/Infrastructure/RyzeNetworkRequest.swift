//
//  RyzeNetworkRequest.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/03/25.
//

@_exported import Foundation
@_exported import RyzeFoundation

public protocol RyzeNetworkRequest: Sendable {
    associatedtype Endpoint: RyzeNetworkEndpoint
    
    var client: RyzeNetworkClient { get async }
    var endpoint: Endpoint? { get async }
    
    func decode<T: RyzeEntity>(
        data: Data,
        with dateStyle: DateFormatter.Style?,
        for type: T.Type
    ) async throws -> T
}

public extension RyzeNetworkRequest {
    func decode<T: RyzeEntity>(
        data: Data,
        with dateStyle: DateFormatter.Style?,
        for type: T.Type
    ) async throws -> T {
        let decoded = try data.entity(for: type, with: dateStyle)
        decoded.log()
        return decoded
    }
}

