//
//  RyzeError.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation
@_exported import os

public protocol RyzeError:
    Error,
    CustomStringConvertible,
    LocalizedError,
    RyzeLogger {
    var errorDescription: String? { get }
    var failureReason: String? { get }
    var recoverySuggestion: String? { get }
}

public extension RyzeError {
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
