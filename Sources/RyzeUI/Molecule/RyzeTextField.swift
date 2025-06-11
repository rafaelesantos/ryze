//
//  RyzeTextField.swift
//  Ryze
//
//  Created by Rafael Escaleira on 07/06/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeTextField: View {
    @Environment(\.ryzeTheme) var theme
    @Binding var text: String
    @FocusState var isFocused: Bool
    private let placeholder: RyzeResourceString
    
    public init(
        text: Binding<String>,
        placheholder: RyzeResourceString
    ) {
        self._text = text
        self.placeholder = placheholder
    }
    
    var needFocus: Bool {
        isFocused || !text.isEmpty
    }
    
    public var body: some View {
        Button {
            isFocused = true
        } label: {
            RyzeVStack(alignment: .leading) {
                TextField(
                    "",
                    text: $text,
                    axis: .vertical
                )
                .focused($isFocused)
                .ryze(alignment: .leading)
                .ryzePadding(.horizontal, spacing: .extraLarge)
                .ryzePadding(.horizontal, spacing: .small)
                .overlay(alignment: .leading) {
                    iconView
                }
                .overlay(alignment: .trailing) {
                    clearButton
                }
                .ryzePadding()
                .ryzeBackgroundSecondary()
                .ryze(clip: .rounded(radius: theme.radius.large))
                .overlay(alignment: .topLeading) {
                    RyzeText(
                        placeholder.value,
                        font: needFocus ? .footnote : .body,
                        color: .disabled
                    )
                    .ryzePadding()
                    .offset(y: needFocus ? -40 : .zero)
                }
            }
            .animation(theme.animation, value: isFocused)
            .animation(theme.animation, value: text.isEmpty)
            
        }
    }
    
    var clearButton: some View {
        Button {
            text = ""
            isFocused = true
        } label: {
            RyzeSymbol(
                name: "xmark.circle.fill",
                color: .textSecondary,
                size: .extraSmall,
                mode: .hierarchical
            )
            .offset(x: needFocus && !text.isEmpty ? .zero : 50)
            .opacity(0.5)
            .scaleEffect(0.8)
        }
    }
    
    var iconView: some View {
        RyzeSymbol(
            name: "envelope.front.fill",
            color: .secondary,
            size: .extraSmall
        )
        .ryzeGlow()
        .offset(x: needFocus ? .zero : -50)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    
    RyzeTextField(
        text: $text,
        placheholder: RyzeUIString.ryzePreviewDescription
    )
    .ryzePadding()
}
