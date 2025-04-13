//
//  RefdsEntity.swift
//  Refds
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

public protocol RefdsEntity:
    Codable,
    Identifiable,
    Equatable,
    Hashable,
    CustomStringConvertible,
    Sendable,
    RefdsLogger {
}

extension RefdsEntity {
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
}

extension Array: RefdsEntity where Element: RefdsEntity {}

extension Array: @retroactive Identifiable where Element: RefdsEntity {
    public var id: UUID { .init() }
}

extension Array: RefdsLogger where Element: RefdsEntity {
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
