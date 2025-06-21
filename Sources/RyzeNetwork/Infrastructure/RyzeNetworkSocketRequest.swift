//
//  RyzeNetworkSocketRequest.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

@_exported import Foundation
@_exported import RyzeFoundation
@_exported import RyzeDependency

public protocol RyzeNetworkSocketRequest: Sendable {
    var client: RyzeNetworkSocketClient { get async }
    var endpoint: RyzeNetworkSocketEndpoint? { get async }
}
