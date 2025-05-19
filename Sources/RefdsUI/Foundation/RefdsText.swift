//
//  RefdsText.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

import SwiftUI

public struct RefdsText: View {
    @Environment(\.refdsTheme) private var theme
    
    private let text: String
    private let font: RefdsFont
    private let color: RefdsColor
    
    public init(
        _ text: String,
        font: RefdsFont = .body,
        color: RefdsColor = .text
    ) {
        self.text = text
        self.font = font
        self.color = color
    }
    
    public var body: Text {
        Text(text)
            .refds(font: font, for: theme)
            .refds(color: color, for: theme)
    }
    
    public static func + (_ lhs: RefdsText, _ rhs: RefdsText) -> Text {
        lhs.body +
        rhs.body
    }
    
    public static func + (_ lhs: Text, _ rhs: RefdsText) -> Text {
        lhs +
        rhs.body
    }
}

#Preview {
    RefdsVStack(spacing: .medium) {
        RefdsText(.refdsPreviewTitle)
        RefdsText(.refdsPreviewDescription, font: .footnote, color: .textSecondary)
    }
    .refds(alignment: .center)
    .refdsPadding(.extraLarge)
    .refds(locale: .portugueseBR)
}
