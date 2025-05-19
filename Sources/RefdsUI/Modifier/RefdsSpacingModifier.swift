//
//  RefdsSpacingModifier.swift
//  Refds
//
//  Created by Rafael Escaleira on 26/04/25.
//

import SwiftUI

struct RefdsSpacingModifier: ViewModifier {
    @Environment(\.refdsTheme) private var theme
    private let edges: Edge.Set
    private let spacing: RefdsSpacing
    
    init(
        edges: Edge.Set,
        spacing: RefdsSpacing
    ) {
        self.edges = edges
        self.spacing = spacing
    }
    
    func body(content: Content) -> some View {
        content.padding(
            edges,
            spacing.rawValue(for: theme.spacing)
        )
    }
}
