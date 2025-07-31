//
//  RyzeBackgroundModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

import SwiftUI

struct RyzeBackgroundModifier: RyzeViewModifier {
    @Environment(\.theme) private var theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.color.background)
    }
    
    static var mock: some View {
        RyzeHStack.mock
            .ryze(width: .max, height: .max)
            .ryzePadding()
            .ryzeBackground()
    }
}

#Preview {
    RyzeBackgroundModifier.mock
}
