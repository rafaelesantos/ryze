//
//  RyzeHStack.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI

public struct RyzeHStack: RyzeView {
    @Environment(\.ryzeTheme) private var theme
    
    let alignment: VerticalAlignment
    let spacing: RyzeSpacing?
    let content: any View
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ accessibility: RyzeAccessibility? = nil,
        alignment: VerticalAlignment = .center,
        spacing: RyzeSpacing? = .medium,
        @ViewBuilder content: () -> some View
    ) {
        self.accessibility = accessibility
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }
    
    public var body: some View {
        HStack(
            alignment: alignment,
            spacing: spacing?.rawValue(for: theme.spacing)
        ) {
            AnyView(content)
        }
        .ryze(accessibility: accessibility)
    }
    
    public static var mock: some View {
        RyzeHStack(
            alignment: .center,
            spacing: .medium
        ) {
            RyzeSymbol.mock
                .ryzePadding()
                .ryzeSurface()
            RyzeVStack.mock
        }
    }
}

#Preview {
    RyzeHStack.mock
}
