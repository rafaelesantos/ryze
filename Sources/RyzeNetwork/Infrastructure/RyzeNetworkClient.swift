//
//  RyzeNetworkClient.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/03/25.
//

@_exported import Foundation
@_exported import RyzeFoundation

public protocol RyzeNetworkClient: Sendable {
    func request<Request: RyzeNetworkRequest, Response: RyzeEntity>(
        on request: Request,
        with dateStyle: DateFormatter.Style?,
        for type: Response.Type
    ) async throws -> Response
}
