//
//  RyzeNetworkSocketEndpoint.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

@_exported import Foundation
@_exported import RyzeFoundation
@_exported import Network

public protocol RyzeNetworkSocketEndpoint: RyzeLogger, Sendable {
    var host: NWEndpoint.Host { get }
    var port: NWEndpoint.Port { get throws }
    var parameters: NWParameters { get }
}

public extension RyzeNetworkSocketEndpoint {
    func log() {
        let logger = RyzeNetworkLogger()
        logger.info("🌐 Host: \(host.debugDescription)")

        if let port = try? port {
            logger.info("🔢 Port: \(port.rawValue)")
        }

        logger.info("⚙️ Parameters: \(parameters.debugDescription)")
    }
}
