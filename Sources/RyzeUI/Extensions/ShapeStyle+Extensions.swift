//
//  ShapeStyle+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 01/07/25.
//

@_exported import SwiftUI

public extension ShapeStyle where Self == RyzeColor {
    static var primary: RyzeColor { .init(keyPath: \.primary) }
    static var secondary: RyzeColor { .init(keyPath: \.secondary) }
    static var background: RyzeColor { .init(keyPath: \.background) }
    static var backgroundSecondary: RyzeColor { .init(keyPath: \.backgroundSecondary) }
    static var shadow: RyzeColor { .init(keyPath: \.shadow) }
    static var surface: RyzeColor { .init(keyPath: \.surface) }
    static var text: RyzeColor { .init(keyPath: \.text) }
    static var textSecondary: RyzeColor { .init(keyPath: \.textSecondary) }
    static var border: RyzeColor { .init(keyPath: \.border) }
    static var error: RyzeColor { .init(keyPath: \.error) }
    static var success: RyzeColor { .init(keyPath: \.success) }
    static var warning: RyzeColor { .init(keyPath: \.warning) }
    static var info: RyzeColor { .init(keyPath: \.info) }
    static var disabled: RyzeColor { .init(keyPath: \.disabled) }
    static var hover: RyzeColor { .init(keyPath: \.hover) }
    static var pressed: RyzeColor { .init(keyPath: \.pressed) }
    static var white: RyzeColor { .init(keyPath: \.white) }
    static var black: RyzeColor { .init(keyPath: \.black) }
    
    static func hex(_ hex: String?) -> RyzeColor {
        guard let hex else { return .primary }
        return .init(rawValue: .init(hex: hex))
    }
    
    static func color(_ color: Color?) -> RyzeColor {
        guard let color else { return .primary }
        return .init(rawValue: color)
    }
}
