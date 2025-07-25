//
//  RyzeSkeletonModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

import SwiftUI

struct RyzeSkeletonModifier: RyzeViewModifier {
    @Environment(\.ryzeTheme) private var theme
    @Environment(\.ryzeLoading) private var isLoading
    
    init() {}
    
    func body(content: Content) -> some View {
        RyzeZStack {
            if isLoading {
                content
                    .redacted(reason: .placeholder)
                    .transition(.blurReplace)
            } else {
                content
                    .transition(.blurReplace)
            }
        }
        .animation(theme.animation, value: isLoading)
    }
    
    static var mock: some View {
        RyzeHStack.mock
            .ryzeSkeleton()
            .ryzePadding()
            .ryze(loading: true)
    }
}

#Preview {
    RyzeSkeletonModifier.mock
}
