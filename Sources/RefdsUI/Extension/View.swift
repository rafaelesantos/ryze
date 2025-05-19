//
//  View.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI
@_exported import RefdsFoundation

public extension View {
    func refds(theme: RefdsThemeProtocol) -> some View {
        self.environment(\.refdsTheme, theme)
    }
    
    func refds(locale: RefdsLocale) -> some View {
        self.environment(\.locale, locale.rawValue)
    }
    
    func refds(alignment: TextAlignment) -> some View {
        self.multilineTextAlignment(alignment)
    }
    
    func refdsPadding(
        _ edges: Edge.Set = .all,
        spacing: RefdsSpacing = .medium
    ) -> some View {
        self.modifier(
            RefdsSpacingModifier(
                edges: edges,
                spacing: spacing
            )
        )
    }
    
    func refdsPadding(
        _ spacing: RefdsSpacing = .medium
    ) -> some View {
        self.modifier(
            RefdsSpacingModifier(
                edges: .all,
                spacing: spacing
            )
        )
    }
    
    func refdsBackground() -> some View {
        self.modifier(RefdsBackgroundModifier())
    }
    
    func refdsSurface(radius: RefdsRadius = .large) -> some View {
        self.modifier(RefdsSurfaceModifier(radius: radius))
    }
    
    func refdsGlow(blur: RefdsSpacing = .medium) -> some View {
        self.modifier(RefdsGlowModifier(blur: blur))
    }
    
    @ViewBuilder
    func refds<Content: View, ElseContent: View>(
        if condition: Bool,
        transform: (Self) -> Content,
        `else`: ((Self) -> ElseContent)? = nil
    ) -> some View {
        if condition { transform(self) }
        else if let `else` { `else`(self) }
        else { self }
    }
    
    @ViewBuilder
    func refds<Content: View, Value, ElseContent: View>(
        item value: Value?,
        transform: (Self, Value) -> Content,
        `else`: ((Self) -> ElseContent)? = nil
    ) -> some View {
        if let value { transform(self, value) }
        else if let `else` { `else`(self) }
        else { self }
    }
    
    static func refdsPreviewDisplayName(
        scheme: ColorScheme,
        locale: RefdsLocale
    ) -> String {
        let className = String(describing: self)
        let schemeName = scheme == .light ? "☀️ Light" : "🌒 Dark"
        let localeName = locale.description
        return "\(className) • \(schemeName) • \(localeName)"
    }
    
    func refdsPreview(
        scheme: ColorScheme,
        locale: RefdsLocale
    ) -> some View {
        self
            .padding()
            .preferredColorScheme(scheme)
            .refds(locale: locale)
    }
}

