//
//  RyzeLabel.swift
//  Ryze
//
//  Created by Rafael Escaleira on 04/07/25.
//

@_exported import SwiftUI

public struct RyzeLabel: RyzeView {
    @Environment(\.ryzeLoading) private var isLoading
    
    let localized: RyzeResourceString?
    let symbol: String
    let font: Font
    let color: RyzeColor?
    let mode: SymbolRenderingMode
    let variants: SymbolVariants
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ localized: RyzeResourceString?,
        _ accessibility: RyzeAccessibility? = nil,
        symbol: String,
        font: Font = .body,
        color: RyzeColor? = nil,
        mode: SymbolRenderingMode = .hierarchical,
        variants: SymbolVariants = .none
    ) {
        self.localized = localized
        self.accessibility = accessibility
        self.symbol = symbol
        self.font = font
        self.color = color
        self.mode = mode
        self.variants = variants
    }
    
    public var body: some View {
        if isLoading {
            Label(
                localized?.value ?? .ryzePreviewDescription,
                systemImage: symbol
            )
            .ryzeSkeleton()
        } else if let localized {
            Label(
                localized.value,
                systemImage: symbol
            )
            .symbolRenderingMode(mode)
            .symbolVariant(variants)
            .ryze(accessibility: accessibility)
            .ryze(font: font)
            .ryze(item: color) { text, color in
                text.foregroundStyle(color)
            }
        }
    }
    
    public static var mock: some View {
        RyzeLabel(
            RyzeUIString.ryzePreviewTitle,
            symbol: "bolt.fill"
        )
    }
}

#Preview {
    RyzeLabel.mock.ryzePadding()
}
