//
//  RyzeFontModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/06/25.
//

struct RyzeFontModifier: ViewModifier {
    @Environment(\.ryzeTheme) var theme
    let font: RyzeFont
    
    init(font: RyzeFont = .body) {
        self.font = font
    }
    
    func body(content: Content) -> some View {
        content
            .font(font.rawValue(for: theme.font))
    }
}
