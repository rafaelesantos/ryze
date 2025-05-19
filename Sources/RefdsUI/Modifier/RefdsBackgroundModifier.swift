//
//  RefdsBackgroundModifier.swift
//  Refds
//
//  Created by Rafael Escaleira on 26/04/25.
//

import SwiftUI

struct RefdsBackgroundModifier: ViewModifier {
    @Environment(\.refdsTheme) private var theme
    
    func body(content: Content) -> some View {
        content.background(theme.color.background)
    }
}

#Preview {
    RefdsVStack {
        
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .refdsBackground()
}
