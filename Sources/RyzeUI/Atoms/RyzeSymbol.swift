//
//  RyzeSymbol.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeSymbol: RyzeView {
    @Environment(\.isLoading) var isLoading
    
    let name: String
    let mode: SymbolRenderingMode
    let variants: SymbolVariants
    
    public init(
        _ name: String = "infinity",
        mode: SymbolRenderingMode = .monochrome,
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
            "wifi",
            variants: .fill,
        )
        .ryzeSymbol(effect: .variableColor.cumulative.dimInactiveLayers.reversing)
    }
}

#Preview {
    RyzeSymbol.mock
}
