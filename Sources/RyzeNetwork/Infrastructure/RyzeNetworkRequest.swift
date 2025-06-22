//
//  RyzeNetworkRequest.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/03/25.
//

@_exported import Foundation
@_exported import RyzeFoundation
@_exported import RyzeDependency

public protocol RyzeNetworkRequest: Sendable {
    var client: RyzeNetworkClient { get async }
    var endpoint: RyzeNetworkEndpoint? { get async }
    
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

