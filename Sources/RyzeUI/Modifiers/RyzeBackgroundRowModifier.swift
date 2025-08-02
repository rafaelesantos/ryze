//
//  RyzeBackgroundRowModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 31/07/25.
//

import SwiftUI

struct RyzeBackgroundRowModifier: RyzeViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        content
            .ryze(background: colorScheme == .dark ? .backgroundSecondary : .background)
    }
    
    static var mock: some View {
        RyzeHStack.mock
            .ryze(width: .max, height: .max)
            .ryzePadding()
            .ryzeBackgroundRow()
    }
}

#Preview {
    RyzeBackgroundModifier.mock
}
