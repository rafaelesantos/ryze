//
//  RyzeGlowModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

import SwiftUI

struct RyzeGlowModifier: ViewModifier {
    @Environment(\.ryzeTheme) private var theme
    private let blur: RyzeSpacing
    
    init(blur: RyzeSpacing) {
        self.blur = blur
    }
    
    func body(content: Content) -> some View {
        content
            .ryze(item: theme.animation) { view, _ in
                view.background(animatedAngularGradient)
            } else: { view in
                view.background(defaultAngularGradient)
            }

    }
    
    private var animatedAngularGradient: some View {
        TimelineView(.animation) { ctx in
            let date = ctx.date.timeIntervalSinceReferenceDate
            let period = theme.glassmorphic.period
            let progress = date.truncatingRemainder(dividingBy: period) / period
            let angle = progress * 360
            
            angularGradient(angle: angle)
        }
    }
    
    private var defaultAngularGradient: some View {
        angularGradient(angle: .zero)
    }
    
    private func angularGradient(angle: Double) -> some View {
        AngularGradient(
            colors: [
                theme.color.primary,
                theme.color.secondary,
                theme.color.primary,
                theme.color.secondary
            ],
            center: .center,
            startAngle: .degrees(angle),
            endAngle: .degrees(angle + 360)
        )
        .blur(radius: theme.glassmorphic.blurRadius)
        .ryzePadding()
        .ryzePadding(spacing: .negative(blur))
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
        .ryzeGlow()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ryzePadding(.extraLarge)
    .ryzeBackground()
}
