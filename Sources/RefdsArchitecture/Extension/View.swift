//
//  View.swift
//  Refds
//
//  Created by Rafael Escaleira on 05/04/25.
//

import SwiftUI

extension View {
    func refdsFull<Item: Identifiable, Content: View>(
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
    
    func refdsAnyView() -> AnyView {
        AnyView(self)
    }
}
