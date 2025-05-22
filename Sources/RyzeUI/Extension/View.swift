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
    
    func ryze(locale: RyzeLocale) -> some View {
        self.environment(\.locale, locale.rawValue)
    }
    
    func ryze(alignment: TextAlignment) -> some View {
        self.multilineTextAlignment(alignment)
    }
    
    func ryzePadding(
        _ edges: Edge.Set = .all,
        spacing: RyzeSpacing = .medium
    ) -> some View {
        self.modifier(
            RyzeSpacingModifier(
                edges: edges,
                spacing: spacing
            )
        )
    }
    
    func ryzePadding(
        _ spacing: RyzeSpacing = .medium
    ) -> some View {
        self.modifier(
            RyzeSpacingModifier(
                edges: .all,
                spacing: spacing
            )
        )
    }
    
    func ryzeBackground() -> some View {
        self.modifier(RyzeBackgroundModifier())
    }
    
    func ryzeSurface(radius: RyzeRadius = .large) -> some View {
        self.modifier(RyzeSurfaceModifier(radius: radius))
    }
    
    func ryzeGlow(blur: RyzeSpacing = .medium) -> some View {
        self.modifier(RyzeGlowModifier(blur: blur))
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
    
    static func ryzePreviewDisplayName(
        scheme: ColorScheme,
        locale: RyzeLocale
    ) -> String {
        let className = String(describing: self)
        let schemeName = scheme == .light ? "☀️ Light" : "🌒 Dark"
        let localeName = locale.description
        return "\(className) • \(schemeName) • \(localeName)"
    }
    
    func ryzePreview(
        scheme: ColorScheme,
        locale: RyzeLocale
    ) -> some View {
        self
            .padding()
            .preferredColorScheme(scheme)
            .ryze(locale: locale)
    }
}

