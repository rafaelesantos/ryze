//
//  RefdsNetworkSocketEndpoint.swift
//  Refds
//
//  Created by Rafael Escaleira on 15/05/25.
//

@_exported import Foundation
@_exported import RefdsFoundation
@_exported import Network

public protocol RefdsNetworkSocketEndpoint: RefdsLogger, Sendable {
    var host: NWEndpoint.Host { get }
    var port: NWEndpoint.Port { get throws }
    var parameters: NWParameters { get }
}

public extension RefdsNetworkSocketEndpoint {
    func log() {
        logger.info("🖥️ Host: \(host.debugDescription)")
        
        if let port = try? port {
            logger.info("🚪 Port: \(port.rawValue)")
        }
        
        logger.info("📦 Parameters: \(parameters.debugDescription)")
    }
}
