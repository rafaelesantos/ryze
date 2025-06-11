//
//  RyzeConditionModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 08/06/25.
//

import SwiftUI

struct RyzeConditionModifier<Transform: View, V: View>: ViewModifier {
    @Environment(\.ryzeTheme) var theme
    let condition: Bool
    let transform: (V) -> Transform
    
    init(
        if condition: Bool,
        transform: @escaping (V) -> Transform
    ) {
        self.condition = condition
        self.transform = transform
    }
    
    func body(content: Content) -> some View {
        RyzeZStack {
            if condition, let content = content as? V {
                transform(content)
                    .transition(.blurReplace)
            } else {
                content
                    .transition(.blurReplace)
            }
        }
        .animation(theme.animation, value: condition)
    }
}
