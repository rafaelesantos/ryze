//
//  RyzeVStack.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI

public struct RyzeVStack<Content: View>: View {
    @Environment(\.ryzeTheme) private var theme
    
    private let alignment: HorizontalAlignment
    private let spacing: RyzeSpacing?
    private let content: Content
    
    public init(
        alignment: HorizontalAlignment = .center,
        spacing: RyzeSpacing? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }
    
    public var body: some View {
        VStack(
            alignment: alignment,
            spacing: spacing?.rawValue(for: theme.spacing)
        ) {
            content
        }
    }
}

#Preview {
    RyzeVStack(alignment: .center, spacing: .medium) {
        RyzeSymbol()
            .ryzePadding()
            .ryzeSurface()
        RyzeSymbol()
            .ryzePadding()
            .ryzeSurface()
            .ryzeGlow()
        RyzeSymbol()
            .ryzePadding()
            .ryzeSurface()
    }
}
