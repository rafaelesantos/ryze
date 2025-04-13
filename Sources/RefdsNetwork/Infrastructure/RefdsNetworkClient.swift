//
//  RefdsNetworkClient.swift
//  Refds
//
//  Created by Rafael Escaleira on 29/03/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

public protocol RefdsNetworkClient: Sendable {
    func request<Request: RefdsNetworkRequest, Response: RefdsEntity>(
        on request: Request,
        with dateStyle: DateFormatter.Style?,
        for type: Response.Type
    ) async throws -> Response
}
