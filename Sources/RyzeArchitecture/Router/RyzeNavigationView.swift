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
    private let destination: (Route) -> any View
    
    public init(
        router: Binding<RyzeRouter<Route>>,
        destination: @escaping (Route) -> any View,
        @ViewBuilder content: @escaping (RyzeRouter<Route>) -> Content
    ) {
        self._router = router
        self.destination = destination
        self.content = content
    }
    
    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            content(router)
                .navigationDestination(for: Route.self) {
                    router.makeView(for: $0, content: destination)
                }
        }
        .sheet(item: $router.presentRoute) {
            router.makeView(for: $0, content: destination)
        }
        .fullScreenCover(item: $router.fullRoute) {
            router.makeView(for: $0, content: destination)
        }
    }
}
