//
//  RyzeColorModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

import SwiftUI

struct RyzeColorModifier: RyzeViewModifier {
    @Environment(\.ryzeTheme) var theme
    let color: RyzeColor
    
    init(color: RyzeColor) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color.rawValue(for: theme.color))
    }
    
    static var mock: some View {
        Text(verbatim: .ryzePreviewDescription)
            .ryze(color: .secondary)
            .ryzePadding()
    }
}

#Preview {
    RyzeColorModifier.mock
}
