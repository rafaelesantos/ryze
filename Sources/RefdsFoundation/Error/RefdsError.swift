//
//  RefdsError.swift
//  Refds
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation
@_exported import os

public protocol RefdsError:
    Error,
    CustomStringConvertible,
    LocalizedError,
    RefdsLogger {
    var errorDescription: String? { get }
    var failureReason: String? { get }
    var recoverySuggestion: String? { get }
}

public extension RefdsError {
    var logger: Logger {
        Logger(
            subsystem: Bundle.main.bundleIdentifier ?? String(describing: Self.self),
            category: String(describing: Self.self)
        )
    }
    
    func log() {
        logger.error("\(localizedDescription)")
        
        if let failureReason {
            logger.warning("\(failureReason)")
        }
        
        if let recoverySuggestion {
            logger.info("\(recoverySuggestion)")
        }
    }
}
