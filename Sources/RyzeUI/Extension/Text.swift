//
//  Text.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/04/25.
//

@_exported import SwiftUI

public extension Text {
    func ryze(
        font: RyzeFont,
        for theme: RyzeThemeProtocol
    ) -> Text {
        self.font(font.rawValue(for: theme.font))
    }
    
    func ryze(
        color: RyzeColor,
        for theme: RyzeThemeProtocol
    ) -> Text {
        self.foregroundStyle(color.rawValue(for: theme.color))
    }
}
