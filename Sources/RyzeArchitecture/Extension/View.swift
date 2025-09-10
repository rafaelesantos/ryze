//
//  View.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/04/25.
//

import SwiftUI

extension View {
    func ryzeFull<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        self.overlay {
            if let item = item.wrappedValue {
                content(item)
                    .transition(.move(edge: .bottom))
                    .ignoresSafeArea()
            }
        }
    }
    
    func ryzeAnyView() -> AnyView {
        AnyView(self)
    }
}

extension EnvironmentValues {
    @Entry var transitionNamespace: Namespace.ID = Namespace().wrappedValue
}
