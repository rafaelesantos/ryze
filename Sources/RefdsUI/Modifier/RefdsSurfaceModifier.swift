//
//  RefdsSurfaceModifier.swift
//  Refds
//
//  Created by Rafael Escaleira on 25/04/25.
//

import SwiftUI

struct RefdsSurfaceModifier: ViewModifier {
    @Environment(\.refdsTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    private let radius: RefdsRadius
    
    init(radius: RefdsRadius) {
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .overlay { background }
            .clipShape(shape)
            .overlay { outilineOverlay }
    }
    
    private var background: some View {
        theme.color.background
            .opacity(colorScheme == .dark ? 0.4 : .zero)
            .clipShape(shape)
            .blendMode(.overlay)
            .allowsHitTesting(false)
    }
    
    private var outilineOverlay: some View {
        shape
            .stroke(
                .linearGradient(
                    colors: [
                        .white.opacity(colorScheme == .dark ? 0.1 : 0.3),
                        .black.opacity(0.1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
    
    private var shape: RefdsShape {
        switch radius {
        case .circle: return RefdsShape(shape: .circle)
        case .capsule: return RefdsShape(shape: .capsule)
        default: return RefdsShape(shape: .rect(cornerRadius: radius.rawValue(for: theme.radius)))
        }
    }
}

#Preview {
    RefdsVStack {
        RefdsVStack(spacing: .medium) {
            RefdsText(.refdsPreviewTitle)
            RefdsText(
                .refdsPreviewDescription,
                font: .footnote,
                color: .textSecondary
            )
        }
        .frame(maxWidth: .infinity)
        .refds(alignment: .center)
        .refdsPadding(.large)
        .refdsSurface(radius: .extraLarge)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .refdsPadding(.extraLarge)
    .refdsBackground()
}
