//
//  RyzeBackgroundRowModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 31/07/25.
//

import SwiftUI

struct RyzeBackgroundRowModifier: RyzeViewModifier {
    @Environment(\.ryzeTheme) private var theme
    
    func body(content: Content) -> some View {
        content
            .ryze(background: theme.colorScheme == .dark ? .backgroundSecondary : .background)
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
