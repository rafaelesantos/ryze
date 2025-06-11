//
//  RyzeZStack.swift
//  Ryze
//
//  Created by Rafael Escaleira on 08/06/25.
//

@_exported import SwiftUI

public struct RyzeZStack<Content: View>: View {
    @Environment(\.ryzeTheme) private var theme
    
    private let alignment: Alignment
    private let content: Content
    
    public init(
        alignment: Alignment = .center,
        spacing: RyzeSpacing? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.content = content()
    }
    
    public var body: some View {
        ZStack(alignment: alignment) {
            content
        }
    }
}

#Preview {
    RyzeZStack(alignment: .center, spacing: .medium) {
        RyzeSymbol()
            .ryzePadding()
            .ryzeSurface()
        RyzeSymbol()
            .ryzePadding()
            .ryzeSurface()
            .ryzeGlow()
        RyzeSymbol()
            .ryzePadding()
            .ryzeSurface()
    }
}
