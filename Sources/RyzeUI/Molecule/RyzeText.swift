//
//  RyzeText.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

import SwiftUI

public struct RyzeText: View {
    @Environment(\.ryzeLoading) private var isLoading
    @Environment(\.ryzeNamespace) private var namespace
    
    private let text: String?
    private let font: RyzeFont
    private let color: RyzeColor
    
    public init(
        _ text: String?,
        font: RyzeFont = .body,
        color: RyzeColor = .text
    ) {
        self.text = text
        self.font = font
        self.color = color
    }
    
    public init(
        _ localized: LocalizedStringResource,
        font: RyzeFont = .body,
        color: RyzeColor = .text
    ) {
        self.text = String(localized: localized)
        self.font = font
        self.color = color
    }
    
    @ViewBuilder
    public var body: some View {
        if let text {
            Text(text)
                .ryze(font: font)
                .ryze(color: color)
                .matchedGeometryEffect(id: text, in: namespace)
        } else if isLoading {
            Text(text ?? .ryzePreviewDescription)
        }
    }
}

#Preview {
    @Previewable @State var title: String = .ryzePreviewTitle
    @Previewable @State var description: String?
    @Previewable @State var isLoading: Bool = false
    
    RyzeHStack(spacing: .large) {
        RyzeSymbol(
            name: "person.crop.circle",
            color: .text,
            size: .extraSmall2,
            mode: .hierarchical,
            variants: .circle
        )
        .ryze(clip: .circle)
        
        RyzeVStack(alignment: .leading, spacing: .small) {
            RyzeText(title)
            RyzeText(description, font: .footnote, color: .textSecondary)
                .ryze(loading: isLoading)
        }
        .ryze(alignment: .leading)
        Spacer()
    }
    .ryzeSkeleton()
    .ryze(alignment: .center)
    .ryzePadding(.extraLarge)
    .task {
        Task {
            try await Task.sleep(for: .seconds(2))
            description = .ryzePreviewDescription
            isLoading.toggle()
            
            try await Task.sleep(for: .seconds(4))
            description = .ryzePreviewDescription
            isLoading.toggle()
        }
    }
    .ryze(loading: isLoading)
}
