//
//  RefdsHStack.swift
//  Refds
//
//  Created by Rafael Escaleira on 26/04/25.
//


@_exported import SwiftUI

public struct RefdsHStack<Content: View>: View {
    @Environment(\.refdsTheme) private var theme
    
    private let alignment: VerticalAlignment
    private let spacing: RefdsSpacing?
    private let content: () -> Content
    
    public init(
        alignment: VerticalAlignment = .center,
        spacing: RefdsSpacing? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        HStack(
            alignment: alignment,
            spacing: spacing?.rawValue(for: theme.spacing)
        ) {
            content()
        }
    }
}

#Preview {
    RefdsHStack(alignment: .center, spacing: .medium) {
        RefdsText(.refdsPreviewEmoji)
            .refdsPadding()
            .refdsSurface()
        RefdsText(.refdsPreviewEmoji)
            .refdsPadding()
            .refdsSurface()
            .refdsGlow()
        RefdsText(.refdsPreviewEmoji)
            .refdsPadding()
            .refdsSurface()
    }
}
