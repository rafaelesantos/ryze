//
//  RyzeHStack.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI

public struct RyzeHStack: RyzeView {
    @Environment(\.ryzeTheme) private var theme
    
    private let alignment: VerticalAlignment
    private let spacing: RyzeSpacing?
    private let content: any View
    
    public init(
        alignment: VerticalAlignment = .center,
        spacing: RyzeSpacing? = .medium,
        @ViewBuilder content: () -> some View
    ) {
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
