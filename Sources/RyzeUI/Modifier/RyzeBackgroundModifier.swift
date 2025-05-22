//
//  RyzeBackgroundModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

import SwiftUI

struct RyzeBackgroundModifier: ViewModifier {
    @Environment(\.ryzeTheme) private var theme
    
    func body(content: Content) -> some View {
        content.background(theme.color.background)
    }
}

#Preview {
    RyzeVStack {
        
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ryzeBackground()
}
