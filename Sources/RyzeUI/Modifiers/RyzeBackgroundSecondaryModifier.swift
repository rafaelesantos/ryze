//
//  RyzeBackgroundSecondaryModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

import SwiftUI

struct RyzeBackgroundSecondaryModifier: RyzeViewModifier {
    @Environment(\.theme) private var theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.color.backgroundSecondary)
    }
    
    static var mock: some View {
        RyzeHStack.mock
            .ryze(width: .max, height: .max)
            .ryzePadding()
            .ryzeBackgroundSecondary()
    }
}

#Preview {
    RyzeBackgroundSecondaryModifier.mock
}
