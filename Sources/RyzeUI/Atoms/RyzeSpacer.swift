//
//  RyzeSpacer.swift
//  Ryze
//
//  Created by Rafael Escaleira on 01/08/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeSpacer: RyzeView {
    @Environment(\.theme) var theme
    
    let size: RyzeSpacing?
    
    public init(size: RyzeSpacing? = .zero) {
        self.size = size
    }
    
    public var body: some View {
        Spacer(minLength: size?.rawValue(for: theme.spacing))
    }
    
    public static var mock: some View {
        RyzeSpacer()
    }
}

#Preview {
    RyzeSymbol.mock
}
