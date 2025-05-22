//
//  RyzeNavigationView.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/04/25.
//

@_exported import SwiftUI

public struct RyzeNavigationView<Content: View, Route: RyzeRoutable>: View {
    @Binding var router: RyzeRouter<Route>
    private let content: (RyzeRouter<Route>) -> Content
    
    public init(
        router: Binding<RyzeRouter<Route>>,
        @ViewBuilder content: @escaping (RyzeRouter<Route>) -> Content
    ) {
        self._router = router
        self.content = content
    }
    
    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            content(router)
                .navigationDestination(for: Route.self) {
                    router.makeView(for: $0)
                }
        }
        .sheet(item: $router.presentRoute) {
            router.makeView(for: $0)
        }
        .ryzeFull(item: $router.fullRoute) {
            router.makeView(for: $0)
        }
    }
}
