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
            .background(.thinMaterial)
            .clipShape(shape)
            .overlay { outilineOverlay }
    }
    
    private var outilineOverlay: some View {
        shape
            .stroke(
                .linearGradient(
                    colors: [
                        .secondary.opacity(0.2),
                        .secondary.opacity(0.1),
                        .secondary.opacity(0.2),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 2.5
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
