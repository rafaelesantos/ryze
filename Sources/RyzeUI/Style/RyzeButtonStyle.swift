//
//  RyzeButtonStyle.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI


public struct RyzeButtonStyle: ButtonStyle {
    @Environment(\.ryzeTheme) private var theme
    @Environment(\.ryzeLoading) private var isLoading
    
    public func makeBody(configuration: Configuration) -> some View {
        RyzeHStack(spacing: .medium) {
            loadingView(with: configuration)
            contentView(with: configuration)
        }
        .frame(maxWidth: .infinity)
        .ryzePadding()
        .ryzeSurface()
        .ryzeGlow()
        .scaleEffect(x: configuration.isPressed && !isLoading ? 0.95 : 1, anchor: .center)
        .sensoryFeedback(theme.feedback, trigger: configuration.isPressed)
        .animation(theme.animation, value: configuration.isPressed)
        .animation(theme.animation, value: isLoading)
    }
    
    @ViewBuilder
    private func loadingView(with configuration: Configuration) -> some View {
        if isLoading, !configuration.isPressed {
            ProgressView()
                .tint(.primary)
                .blendMode(.overlay)
                .transition(.scale)
        }
    }
    
    @ViewBuilder
    private func contentView(with configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .blendMode(.overlay)
    }
}


#Preview {
    @Previewable @Environment(\.ryzeTheme) var theme
    @Previewable @State var title: String? = .ryzePreviewTitle
    @Previewable @State var isLoading: Bool = false
    
    Button {
        if !isLoading {
            isLoading.toggle()
        }
    } label: {
        RyzeText(
            title,
            font: .headline
        )
    }
    .buttonStyle(RyzeButtonStyle())
    .ryzePadding(.extraLarge)
    .ryze(loading: isLoading)
    .onChange(of: isLoading) {
        guard isLoading else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isLoading.toggle()
        }
    }
}
