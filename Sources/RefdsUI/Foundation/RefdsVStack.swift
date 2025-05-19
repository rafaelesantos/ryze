//
//  RefdsVStack.swift
//  Refds
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI

public struct RefdsVStack<Content: View>: View {
    @Environment(\.refdsTheme) private var theme
    
    private let alignment: HorizontalAlignment
    private let spacing: RefdsSpacing?
    private let content: () -> Content
    
    public init(
        alignment: HorizontalAlignment = .center,
        spacing: RefdsSpacing? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        VStack(
            alignment: alignment,
            spacing: spacing?.rawValue(for: theme.spacing)
        ) {
            content()
        }
    }
}

#Preview {
    RefdsVStack(alignment: .center, spacing: .medium) {
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
