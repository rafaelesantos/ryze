//
//  Text.swift
//  Refds
//
//  Created by Rafael Escaleira on 24/04/25.
//

@_exported import SwiftUI

public extension Text {
    func refds(
        font: RefdsFont,
        for theme: RefdsThemeProtocol
    ) -> Text {
        self.font(font.rawValue(for: theme.font))
    }
    
    func refds(
        color: RefdsColor,
        for theme: RefdsThemeProtocol
    ) -> Text {
        self.foregroundStyle(color.rawValue(for: theme.color))
    }
}
