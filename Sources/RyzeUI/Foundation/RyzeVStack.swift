//
//  RyzeVStack.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI

public struct RyzeVStack: RyzeView {
    @Environment(\.ryzeTheme) private var theme
    
    private let alignment: HorizontalAlignment
    private let spacing: RyzeSpacing?
    private let content: any View
    
    public init(
        alignment: HorizontalAlignment = .center,
        spacing: RyzeSpacing? = nil,
        @ViewBuilder content: () -> some View
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }
    
    public var body: some View {
        VStack(
            alignment: alignment,
            spacing: spacing?.rawValue(for: theme.spacing)
        ) {
            AnyView(content)
        }
    }
    
    public static var mock: some View {
        RyzeVStack(alignment: .leading) {
            RyzeText.mock
            RyzeText.mock
        }
        .ryze(width: .max)
    }
}

#Preview {
    RyzeVStack.mock
}
