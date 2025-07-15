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
    
    let name: String
    let mode: SymbolRenderingMode
    let variants: SymbolVariants
    
    public init(
        name: String = "infinity",
        mode: SymbolRenderingMode = .hierarchical,
        variants: SymbolVariants = .none
    ) {
        self.name = name
        self.mode = mode
        self.variants = variants
    }
    
    public var body: some View {
        Image(systemName: name)
            .symbolRenderingMode(mode)
            .symbolVariant(variants)
            .ryzeSkeleton()
    }
    
    public static var mock: some View {
        RyzeSymbol(
            name: "wifi",
            variants: .fill,
        )
        .ryzeSymbol(effect: .variableColor.cumulative.dimInactiveLayers.reversing)
    }
}

#Preview {
    RyzeSymbol.mock
}
