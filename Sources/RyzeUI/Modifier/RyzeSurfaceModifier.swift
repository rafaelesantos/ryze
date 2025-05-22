//
//  RyzeSurfaceModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

import SwiftUI

struct RyzeSurfaceModifier: ViewModifier {
    @Environment(\.ryzeTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    private let radius: RyzeRadius
    
    init(radius: RyzeRadius) {
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
    
    private var shape: RyzeShape {
        switch radius {
        case .circle: return RyzeShape(shape: .circle)
        case .capsule: return RyzeShape(shape: .capsule)
        default: return RyzeShape(shape: .rect(cornerRadius: radius.rawValue(for: theme.radius)))
        }
    }
}

#Preview {
    RyzeVStack {
        RyzeVStack(spacing: .medium) {
            RyzeText(.ryzePreviewTitle)
            RyzeText(
                .ryzePreviewDescription,
                font: .footnote,
                color: .textSecondary
            )
        }
        .frame(maxWidth: .infinity)
        .ryze(alignment: .center)
        .ryzePadding(.large)
        .ryzeSurface(radius: .extraLarge)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ryzePadding(.extraLarge)
    .ryzeBackground()
}
