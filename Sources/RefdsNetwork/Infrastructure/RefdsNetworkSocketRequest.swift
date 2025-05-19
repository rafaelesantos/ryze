//
//  RefdsNetworkSocketRequest.swift
//  Refds
//
//  Created by Rafael Escaleira on 15/05/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

public protocol RefdsNetworkSocketRequest: Sendable {
    var client: RefdsNetworkSocketClient { get async }
    var endpoint: RefdsNetworkSocketEndpoint? { get async }
}
