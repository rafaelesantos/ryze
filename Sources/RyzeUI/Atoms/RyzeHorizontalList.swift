//
//  RyzeHorizontalList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/07/25.
//

@_exported import SwiftUI

public struct RyzeHorizontalList: RyzeView {
    let content: (ScrollViewProxy) -> any View
    
    public init(@ViewBuilder content: @escaping (ScrollViewProxy) -> some View) {
        self.content = content
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                AnyView(content(proxy))
            }
            .scrollIndicators(.hidden)
        }
    }
    
    public static var mock: some View {
        RyzeHorizontalList { _ in
            RyzeHStack.mock
            RyzeHStack.mock
        }
    }
}

#Preview {
    RyzeHorizontalList.mock
}
