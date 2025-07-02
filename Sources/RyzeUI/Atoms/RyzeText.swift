//
//  RyzeText.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

import SwiftUI

public struct RyzeText: RyzeView {
    @Environment(\.ryzeLoading) private var isLoading
    @Environment(\.ryzeNamespace) private var namespace
    
    private let text: String?
    private let font: RyzeFont
    private let color: RyzeColor?
    
    public init(
        _ localized: RyzeResourceString?,
        font: RyzeFont = .body,
        color: RyzeColor? = nil
    ) {
        self.text = localized?.value
        self.font = font
        self.color = color
    }
    
    public init(
        _ text: String?,
        font: RyzeFont = .body,
        color: RyzeColor? = nil
    ) {
        self.text = text
        self.font = font
        self.color = color
    }
    
    @ViewBuilder
    public var body: some View {
        if isLoading {
            Text(text ?? .ryzePreviewDescription)
                .ryzeSkeleton()
        } else if let text {
            Text(text)
                .ryze(font: font)
                .ryze(item: color) { text, color in
                    text.foregroundStyle(color)
                }
                .matchedGeometryEffect(id: text, in: namespace)
        }
    }
    
    public static var mock: some View {
        RyzeText(
            RyzeUIString.ryzePreviewDescription,
            font: .title2,
            color: .textSecondary
        )
    }
}

#Preview {
    RyzeText.mock
}
