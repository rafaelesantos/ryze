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
    func log() {
        let logger = RyzeFoundationLogger()
        logger.error(.error(self))
        
        if let failureReason {
            logger.warning(.message(failureReason))
        }
        
        if let recoverySuggestion {
            logger.info(.message(recoverySuggestion))
        }
    }
}
