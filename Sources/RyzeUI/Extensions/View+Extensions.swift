//
//  View.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public extension View {
    func ryze(background style: RyzeColor) -> some View {
        self.background(style)
    }
    
    func ryze(tint color: RyzeColor) -> some View {
        self.tint(color)
    }
    
    func ryze(color: RyzeColor) -> some View {
        self.foregroundStyle(color)
    }
    
    func ryze(theme: RyzeThemeProtocol) -> some View {
        self.environment(\.theme, theme)
    }
    
    func ryze(locale: RyzeLocale) -> some View {
        self.environment(\.locale, locale.rawValue)
    }
    
    func ryze(colorScheme: ColorScheme? = nil) -> some View {
        self.preferredColorScheme(colorScheme)
    }
    
    func ryze(loading: Bool) -> some View {
        self.environment(\.isLoading, loading)
    }
    
    func ryze(disabled: Bool) -> some View {
        self.environment(\.isDisabled, disabled)
    }
    
    func ryze(alignment: TextAlignment) -> some View {
        self.multilineTextAlignment(alignment)
    }
    
    func ryze(
        font: Font = .body,
        weight: Font.Weight? = nil,
        design: Font.Design? = nil
    ) -> some View {
        self.font(font)
            .fontWeight(weight)
            .fontDesign(design)
    }
    
    func ryze(
        width: RyzeSize? = nil,
        height: RyzeSize? = nil,
        alignment: Alignment = .center
    ) -> some View {
        self.modifier(
            RyzeSizeModifier(
                width: width,
                height: height,
                alignment: alignment
            )
        )
    }
    
    func ryzePadding(
        _ edges: Edge.Set = .all,
        _ spacing: RyzeSpacing = .medium
    ) -> some View {
        self.modifier(RyzeSpacingModifier(edges: edges, spacing: spacing))
    }
    
    func ryzePadding(
        _ spacing: RyzeSpacing = .medium
    ) -> some View {
        self.modifier(RyzeSpacingModifier(edges: .all, spacing: spacing))
    }
    
    func ryzeBackground() -> some View {
        self.modifier(RyzeBackgroundModifier())
    }
    
    func ryzeBackgroundSecondary() -> some View {
        self.modifier(RyzeBackgroundSecondaryModifier())
    }
    
    func ryzeBackgroundRow() -> some View {
        self.modifier(RyzeBackgroundRowModifier())
    }
    
    func ryzeGlow(for color: Color? = nil) -> some View {
        self.modifier(RyzeGlowModifier(color: color))
    }
    
    func ryzeSymbol<T: IndefiniteSymbolEffect & SymbolEffect>(
        effect: T,
        options: SymbolEffectOptions = .default,
        isActive: Bool = true
    ) -> some View {
        self.symbolEffect(
            effect,
            options: options,
            isActive: isActive
        )
    }
    
    @ViewBuilder
    func ryze<Content: View>(
        if condition: Bool,
        transition: AnyTransition = .scale,
        animation: Animation? = .linear,
        transform: (Self) -> Content
    ) -> some View {
        RyzeZStack {
            if condition {
                transform(self)
                    .transition(transition)
            } else {
                self
            }
        }
        .animation(animation, value: condition)
    }
    
    @ViewBuilder
    func ryze<Content: View, Value>(
        item value: Value?,
        transform: (Self, Value) -> Content
    ) -> some View {
        if let value { transform(self, value) }
        else { self }
    }
    
    @ViewBuilder
    func ryze<Content: View, ElseContent: View>(
        if condition: Bool,
        transform: (Self) -> Content,
        `else`: ((Self) -> ElseContent)? = nil
    ) -> some View {
        if condition { transform(self) }
        else if let `else` { `else`(self) }
        else { self }
    }
    
    @ViewBuilder
    func ryze<Content: View, Value, ElseContent: View>(
        item value: Value?,
        transform: (Self, Value) -> Content,
        `else`: ((Self) -> ElseContent)? = nil
    ) -> some View {
        if let value { transform(self, value) }
        else if let `else` { `else`(self) }
        else { self }
    }
    
    func ryzeSkeleton() -> some View {
        self.modifier(RyzeSkeletonModifier())
    }
    
    @ViewBuilder
    func ryzeParallax(width: RyzeSize? = nil, height: RyzeSize?) -> some View {
        #if os(iOS)
        self.modifier(RyzeParallaxModifier(width: width, height: height))
        #else
        self
        #endif
    }
    
    func ryze(clip shape: RyzeShape) -> some View {
        self.clipShape(shape)
    }
    
    func ryzePreview(
        layout: PreviewLayout,
        orientation: InterfaceOrientation,
        colorScheme: ColorScheme,
        locale: RyzeLocale
    ) -> some View {
        self
            .ryzePadding(.extraLarge)
            .ryzeBackground()
            .ryze(locale: locale)
            .previewLayout(layout)
            .previewInterfaceOrientation(orientation)
            .preferredColorScheme(colorScheme)
            .previewDisplayName(
                .ryzePreviewDisplayName(
                    Self.self,
                    scheme: colorScheme,
                    locale: locale
                )
            )
    }
    
    @ViewBuilder
    func ryze(accessibility: RyzeAccessibility?) -> some View {
        if let accessibility = accessibility {
            self
                .accessibilityLabel(accessibility.label.value)
                .accessibilityHint(accessibility.hint.value)
                .accessibilityIdentifier(accessibility.identifier.value)
        } else {
            self
        }
    }
    
    func ryzeScreenObserve(minimumWidthScreen: CGFloat = 430) -> some View {
        self.modifier(RyzeScreenModifier(minimumWidthScreen: minimumWidthScreen))
    }
    
    func ryzeConfetti(
        amount: Int = 30,
        seconds: Int = 4,
        isActive: Bool
    ) -> some View {
        self.modifier(
            RyzeConfettiModifier(
                amount: amount,
                seconds: seconds,
                isActive: isActive
            )
        )
    }
    
    func ryze(systemMonitor: Binding<RyzeSystemMonitor>) -> some View {
        self.modifier(RyzeSystemMonitorModifier(systemMonitor: systemMonitor))
    }
    
    func ryzeBrowser(url: Binding<URL?>) -> some View {
        self.sheet(item: url) { url in
            RyzeBrowser(url: url)
        }
    }
}
