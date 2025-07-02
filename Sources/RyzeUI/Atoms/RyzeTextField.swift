//
//  RyzeTextField.swift
//  Ryze
//
//  Created by Rafael Escaleira on 07/06/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeTextField: RyzeView {
    @Environment(\.ryzeTheme) var theme
    @FocusState var isFocused: Bool
    @Binding var text: String
    @State var error: RyzeError?
    
    private let configuration: RyzeTextFieldConfiguration
    
    public init(
        text: Binding<String>,
        configuration: RyzeTextFieldConfiguration
    ) {
        self._text = text
        self.configuration = configuration
    }
    
    var needFocus: Bool {
        isFocused || !text.isEmpty
    }
    
    var stateColor: RyzeColor {
        error == nil && !text.isEmpty ? .success :
        error == nil ? .secondary : .error
    }
    
    public var body: some View {
        Button { isFocused = true } label: {
            RyzeVStack(alignment: .leading) {
                contentTextField
                    .overlay(alignment: .topLeading) { placeholderView }
                
                errorView
            }
            .animation(theme.animation, value: isFocused)
            .animation(theme.animation, value: text.isEmpty)
            .animation(theme.animation, value: error?.localizedDescription)
            .onChange(of: text) { validate() }
        }
    }
    
    var contentTextField: some View {
        TextField(
            "",
            text: $text,
            axis: .vertical
        )
        .focused($isFocused)
        .autocorrectionDisabled()
        #if os(iOS)
        .keyboardType(configuration.contentType.rawValue)
        .textInputAutocapitalization(configuration.autocapitalizationType.rawValue)
        #endif
        .submitLabel(configuration.submitLabel)
        .ryze(alignment: .leading)
        .ryzePadding(.horizontal, spacing: .extraLarge)
        .ryzePadding(.horizontal, spacing: .small)
        .overlay(alignment: .leading) { iconView }
        .overlay(alignment: .trailing) { clearButton }
        .ryzePadding()
        .ryzeBackgroundSecondary()
        .ryze(clip: .rounded(radius: theme.radius.large))
    }
    
    func validate() {
        do {
            try configuration.validate(text: text)
            self.error = nil
        } catch let error as RyzeError {
            self.error = error
        } catch {
            
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
    
    @ViewBuilder
    var iconView: some View {
        if let icon = configuration.icon {
            RyzeSymbol(
                name: icon,
                color: stateColor,
                size: .extraSmall
            )
            .ryzeGlow(for: error == nil ? nil : theme.color.error)
            .offset(x: needFocus ? .zero : -50)
        }
    }
    
    @ViewBuilder
    var placeholderView: some View {
        RyzeText(
            configuration.placeholder,
            font: needFocus ? .footnote : .body,
            color: .disabled
        )
        .lineLimit(1)
        .ryzePadding()
        .offset(y: needFocus ? -40 : .zero)
    }
    
    @ViewBuilder
    var errorView: some View {
        if error != nil {
            RyzeVStack(alignment: .leading) {
                failureReasonView
                recoverySuggestionView
            }
            .ryze(width: .max)
            .transition(.blurReplace)
        }
    }
    
    @ViewBuilder
    var failureReasonView: some View {
        if let failureReason = error?.failureReason {
            RyzeHStack(spacing: .small) {
                RyzeSymbol(
                    name: "xmark.circle.fill",
                    color: .error,
                    size: .ultraSmall2,
                    mode: .hierarchical
                )
                
                RyzeText(
                    failureReason,
                    font: needFocus ? .footnote : .body,
                    color: .disabled
                )
                .ryze(alignment: .leading)
            }
        }
    }
    
    @ViewBuilder
    var recoverySuggestionView: some View {
        if let recoverySuggestion = error?.recoverySuggestion {
            RyzeHStack(spacing: .small) {
                RyzeSymbol(
                    name: "lightbulb.max.fill",
                    color: .success,
                    size: .ultraSmall2,
                    mode: .hierarchical
                )
                
                RyzeText(
                    recoverySuggestion,
                    font: needFocus ? .footnote : .body,
                    color: .disabled
                )
                .ryze(alignment: .leading)
            }
        }
    }
    
    public static var mock: some View {
        RyzeTextField(
            text: .constant(""),
            configuration: RyzeDefaultTextFieldConfiguration.email
        )
    }
}

#Preview {
    @Previewable @State var text: String = ""
    RyzeTextField(
        text: $text,
        configuration: RyzeDefaultTextFieldConfiguration.email
    )
    .ryzePadding()
}
