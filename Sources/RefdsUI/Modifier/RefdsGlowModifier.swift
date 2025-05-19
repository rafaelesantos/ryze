//
//  RefdsGlowModifier.swift
//  Refds
//
//  Created by Rafael Escaleira on 25/04/25.
//

import SwiftUI

struct RefdsGlowModifier: ViewModifier {
    @Environment(\.refdsTheme) private var theme
    private let blur: RefdsSpacing
    
    init(blur: RefdsSpacing) {
        self.blur = blur
    }
    
    func body(content: Content) -> some View {
        content
            .refds(item: theme.animation) { view, _ in
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
            colors: theme.glassmorphic.colors,
            center: .center,
            startAngle: .degrees(angle),
            endAngle: .degrees(angle + 360)
        )
        .blur(radius: theme.glassmorphic.blurRadius)
        .refdsPadding()
        .refdsPadding(spacing: .negative(blur))
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
        .refdsGlow()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .refdsPadding(.extraLarge)
    .refdsBackground()
}
