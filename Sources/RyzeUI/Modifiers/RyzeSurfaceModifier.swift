//
//  RyzeSurfaceModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

import SwiftUI

struct RyzeSurfaceModifier: RyzeViewModifier {
    @Environment(\.ryzeTheme) private var theme
    
    func body(content: Content) -> some View {
        content
    }
    
    static var mock: some View {
        RyzeHStack.mock
            .ryzePadding()
            .ryzeSurface()
            .ryzePadding()
    }
}

#Preview {
    RyzeSurfaceModifier.mock
}
