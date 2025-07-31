//
//  RyzeZStack.swift
//  Ryze
//
//  Created by Rafael Escaleira on 08/06/25.
//

@_exported import SwiftUI

public struct RyzeZStack: RyzeView {
    let alignment: Alignment
    let content: any View
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ accessibility: RyzeAccessibility? = nil,
        alignment: Alignment = .center,
        spacing: RyzeSpacing? = nil,
        @ViewBuilder content: () -> some View
    ) {
        self.accessibility = accessibility
        self.alignment = alignment
        self.content = content()
    }
    
    public var body: some View {
        ZStack(alignment: alignment) {
            AnyView(content)
        }
        .ryze(accessibility: accessibility)
    }
    
    public static var mock: some View {
        RyzeZStack {
            RyzeSymbol.mock
        }
    }
}

#Preview {
    RyzeZStack.mock
}
