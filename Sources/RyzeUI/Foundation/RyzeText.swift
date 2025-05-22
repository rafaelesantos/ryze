//
//  RyzeText.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

import SwiftUI

public struct RyzeText: View {
    @Environment(\.ryzeTheme) private var theme
    
    private let text: String
    private let font: RyzeFont
    private let color: RyzeColor
    
    public init(
        _ text: String,
        font: RyzeFont = .body,
        color: RyzeColor = .text
    ) {
        self.text = text
        self.font = font
        self.color = color
    }
    
    public var body: Text {
        Text(text)
            .ryze(font: font, for: theme)
            .ryze(color: color, for: theme)
    }
    
    public static func + (_ lhs: RyzeText, _ rhs: RyzeText) -> Text {
        lhs.body +
        rhs.body
    }
    
    public static func + (_ lhs: Text, _ rhs: RyzeText) -> Text {
        lhs +
        rhs.body
    }
}

#Preview {
    RyzeVStack(spacing: .medium) {
        RyzeText(.ryzePreviewTitle)
        RyzeText(.ryzePreviewDescription, font: .footnote, color: .textSecondary)
    }
    .ryze(alignment: .center)
    .ryzePadding(.extraLarge)
    .ryze(locale: .portugueseBR)
}
