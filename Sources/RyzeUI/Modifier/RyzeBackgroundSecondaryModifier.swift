//
//  RyzeBackgroundSecondaryModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

import SwiftUI

struct RyzeBackgroundSecondaryModifier: ViewModifier {
    @Environment(\.ryzeTheme) private var theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.color.backgroundSecondary)
    }
}

#Preview {
    RyzeVStack {
        
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ryzeBackgroundSecondary()
}
