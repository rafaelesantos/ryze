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
    associatedtype Response: RyzeEntity
    
    var endpoint: Endpoint { get async }
    
    func decode(
        data: Data,
        with formatter: DateFormatter?
    ) async throws -> Response
}

public extension RyzeNetworkRequest {
    func decode(
        data: Data,
        with formatter: DateFormatter?
    ) async throws -> Response {
        let decoded = try data.entity(
            for: Response.self,
            with: formatter
        )
        decoded.log()
        return decoded
    }
}

