//
//  RyzeList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/06/25.
//

@_exported import SwiftUI

public struct RyzeList: RyzeView {
    @Environment(\.ryzeTheme) private var theme
    
    private let content: any View
    
    public init(@ViewBuilder content: () -> some View) {
        self.content = content()
    }
    
    public var body: some View {
        List {
            AnyView(content)
        }
    }
    
    public static var mock: some View {
        RyzeList {
            RyzeText.mock
            RyzeSection.mock
            RyzeText.mock
            RyzeHStack.mock
            RyzeSection.mock
        }
    }
}

#Preview {
    RyzeList.mock
}
