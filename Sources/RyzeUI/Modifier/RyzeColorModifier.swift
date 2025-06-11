//
//  RyzeColorModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

import SwiftUI

struct RyzeColorModifier: ViewModifier {
    @Environment(\.ryzeTheme) var theme
    let color: RyzeColor
    
    init(color: RyzeColor) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color.rawValue(for: theme.color))
    }
}
