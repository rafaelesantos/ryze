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
}

public extension Color {
    static func hex(_ hex: String?) -> Color {
        guard let hex else { return Color(.primary) }
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return Color(.primary)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
    
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        #if canImport(UIKit)
        let uiColor = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
        return Color(uiColor: uiColor)
        #elseif canImport(AppKit)
        let nsColor = NSColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
        return Color(nsColor: nsColor)
        #else
        return Color(.primary)
        #endif
    }
}
