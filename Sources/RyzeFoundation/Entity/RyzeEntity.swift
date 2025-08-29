//
//  RyzeEntity.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

public protocol RyzeEntity:
    Codable,
    Identifiable,
    Equatable,
    Hashable,
    CustomStringConvertible,
    RyzeLogger {
}

extension RyzeEntity {
    public func log() {
        let logger = RyzeFoundationLogger()
        do {
            let content = try json
            logger.info(.message(content))
        } catch {
            logger.error(.error(error))
        }
    }
    
    public var description: String {
        do {
            return try json
        } catch {
            return error.localizedDescription
        }
    }
}

extension Array: RyzeEntity where Element: RyzeEntity {}

extension Array: @retroactive Identifiable where Element: RyzeEntity {
    public var id: UUID { .init() }
}

extension Array: RyzeLogger where Element: RyzeEntity {
    public func log() {
        let logger = RyzeFoundationLogger()
        do {
            let content = try json
            logger.info(.message(content))
        } catch {
            logger.error(.error(error))
        }
    }
}
