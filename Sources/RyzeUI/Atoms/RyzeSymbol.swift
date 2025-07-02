//
//  RyzeSymbol.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeSymbol: RyzeView {
    @Environment(\.ryzeLoading) var isLoading
    
    private let name: String
    private let color: RyzeColor
    private let size: RyzeSize
    private let mode: SymbolRenderingMode
    private let variants: SymbolVariants
    
    public init(
        name: String = "infinity",
        color: RyzeColor = .primary,
        size: RyzeSize = .ultraSmall2,
        mode: SymbolRenderingMode = .hierarchical,
        variants: SymbolVariants = .none
    ) {
        self.name = name
        self.color = color
        self.size = size
        self.mode = mode
        self.variants = variants
    }
    
    public var body: some View {
        Image(systemName: name)
            .resizable()
            .scaledToFit()
            .foregroundStyle(color)
            .ryze(width: size, height: size)
            .symbolRenderingMode(mode)
            .symbolVariant(variants)
            .ryzeSkeleton()
    }
    
    public static var mock: some View {
        RyzeSymbol(
            name: "wifi",
            color: .secondary,
            variants: .fill,
        )
        .ryzeSymbol(effect: .variableColor.cumulative.dimInactiveLayers.reversing)
    }
}

#Preview {
    RyzeSymbol.mock
}
