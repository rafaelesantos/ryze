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
    Sendable,
    RyzeLogger {
}

extension RyzeEntity {
    public var logger: Logger {
        Logger(
            subsystem: Bundle.main.bundleIdentifier ?? String(describing: Self.self),
            category: String(describing: Self.self)
        )
    }
    
    public func log() {
        do {
            let content = try json
            logger.info("\(content)")
        } catch {
            logger.error("\(error.localizedDescription)")
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
    public var logger: Logger {
        Logger(
            subsystem: Bundle.main.bundleIdentifier ?? String(describing: Element.self),
            category: String(describing: Element.self)
        )
    }
    
    public func log() {
        do {
            let content = try json
            logger.info("\(content)")
        } catch {
            logger.error("\(error.localizedDescription)")
        }
    }
}
