//
//  RefdsNetworkRequest.swift
//  Refds
//
//  Created by Rafael Escaleira on 29/03/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

public protocol RefdsNetworkRequest: Sendable {
    var client: RefdsNetworkClient { get async }
    var endpoint: RefdsNetworkEndpoint? { get async }
    
    func decode<T: RefdsEntity>(
        data: Data,
        with dateStyle: DateFormatter.Style?,
        for type: T.Type
    ) async throws -> T
}

public extension RefdsNetworkRequest {
    func decode<T: RefdsEntity>(
        data: Data,
        with dateStyle: DateFormatter.Style?,
        for type: T.Type
    ) async throws -> T {
        let decoded = try data.entity(for: type, with: dateStyle)
        decoded.log()
        return decoded
    }
}

