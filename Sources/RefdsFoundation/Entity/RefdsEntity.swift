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
