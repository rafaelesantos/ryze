//
//  View.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public extension View {
    func ryze(theme: RyzeThemeProtocol) -> some View {
        self.environment(\.ryzeTheme, theme)
    }
    
    func ryze(color: RyzeColor) -> some View {
        self.modifier(RyzeColorModifier(color: color))
    }
    
    func ryze(locale: RyzeLocale) -> some View {
        self.environment(\.locale, locale.rawValue)
    }
    
    func ryze(colorScheme: ColorScheme? = nil) -> some View {
        self.preferredColorScheme(colorScheme)
    }
    
    func ryze(loading: Bool) -> some View {
        self.environment(\.ryzeLoading, loading)
    }
    
    func ryze(disabled: Bool) -> some View {
        self.environment(\.ryzeDisabled, disabled)
    }
    
    func ryze(alignment: TextAlignment) -> some View {
        self.multilineTextAlignment(alignment)
    }
    
    func ryze(font: RyzeFont) -> some View {
        self.modifier(RyzeFontModifier(font: font))
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
        spacing: RyzeSpacing = .medium
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
    
    func ryzeSurface() -> some View {
        self.modifier(RyzeSurfaceModifier())
    }
    
    func ryzeGlow(for color: Color? = nil) -> some View {
        self.modifier(RyzeGlowModifier(color: color))
    }
    
    func ryzeSymbol<T: IndefiniteSymbolEffect & SymbolEffect>(
        effect: T,
        isActive: Bool = true
    ) -> some View {
        self.symbolEffect(effect, isActive: isActive)
    }
    
    @ViewBuilder
    func ryze<Content: View>(
        if condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        RyzeZStack {
            if condition {
                transform(self)
                    .transition(.blurReplace)
            } else {
                self
                    .transition(.blurReplace)
            }
        }
        .animation(.interactiveSpring(duration: 0.8), value: condition)
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
    
    func ryzeGlass() -> some View {
        self.glassEffect(.regular.interactive())
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
}
