//
//  RyzeHorizontalList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/07/25.
//

@_exported import SwiftUI

public struct RyzeHorizontalList: RyzeView {
    let content: any View
    
    public init(@ViewBuilder content: () -> some View) {
        self.content = content()
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            AnyView(content)
        }
        .scrollIndicators(.hidden)
    }
    
    public static var mock: some View {
        RyzeHorizontalList {
            RyzeHStack.mock
            RyzeHStack.mock
        }
    }
}

#Preview {
    RyzeHorizontalList.mock
}
