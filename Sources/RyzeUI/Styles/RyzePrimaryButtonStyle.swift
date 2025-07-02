//
//  RyzePrimaryButtonStyle.swift
//  Ryze
//
//  Created by Rafael Escaleira on 01/07/25.
//

@_exported import SwiftUI

struct RyzePrimaryButtonStyle: ButtonStyle {
    @Environment(\.ryzeTheme) var theme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .lineLimit(1)
            .controlSize(.regular)
            .ryze(background: .primary)
    }
}

#Preview {
    RyzeButton {} label: {
        RyzeText(
            .ryzePreviewTitle,
            color: .white
        )
    }
    .buttonStyle(RyzePrimaryButtonStyle())
}
