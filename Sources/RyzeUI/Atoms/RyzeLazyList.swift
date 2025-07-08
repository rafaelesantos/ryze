//
//  RyzeLazyList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI

public struct RyzeLazyList: RyzeView {
    @Environment(\.ryzeTheme) var theme
    let content: any View
    
    public init(@ViewBuilder content: () -> some View) {
        self.content = content()
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: theme.spacing.medium) {
                AnyView(content)
            }
            .ryzePadding()
        }
    }
    
    public static var mock: some View {
        RyzeLazyList {
            RyzeText.mock
            RyzeHStack.mock
            RyzeText.mock
            RyzeVStack.mock
        }
    }
}

#Preview {
    RyzeLazyList.mock
}
