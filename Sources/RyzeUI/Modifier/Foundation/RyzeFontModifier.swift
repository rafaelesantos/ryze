//
//  RyzeFontModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/06/25.
//

struct RyzeFontModifier: RyzeViewModifier {
    @Environment(\.ryzeTheme) var theme
    let font: RyzeFont
    
    init(font: RyzeFont = .body) {
        self.font = font
    }
    
    func body(content: Content) -> some View {
        content
            .font(font.rawValue(for: theme.font))
    }
    
    static var mock: some View {
        Text(verbatim: .ryzePreviewDescription)
            .ryze(font: .largeTitle)
            .ryzePadding()
    }
}

#Preview {
    RyzeFontModifier.mock
}
