//
//  RyzeZStack.swift
//  Ryze
//
//  Created by Rafael Escaleira on 08/06/25.
//

@_exported import SwiftUI

public struct RyzeZStack: RyzeView {
    @Environment(\.ryzeTheme) private var theme
    
    private let alignment: Alignment
    private let content: any View
    
    public init(
        alignment: Alignment = .center,
        spacing: RyzeSpacing? = nil,
        @ViewBuilder content: () -> some View
    ) {
        self.alignment = alignment
        self.content = content()
    }
    
    public var body: some View {
        ZStack(alignment: alignment) {
            AnyView(content)
        }
    }
    
    public static var mock: some View {
        RyzeZStack {
            RyzeSymbol(
                name: "circle.fill",
                color: .secondary,
                size: .medium,
                mode: .hierarchical
            )
            
            RyzeSymbol(
                name: "apple.logo",
                color: .primary,
                size: .small
            )
        }
    }
}

#Preview {
    RyzeZStack.mock
}
