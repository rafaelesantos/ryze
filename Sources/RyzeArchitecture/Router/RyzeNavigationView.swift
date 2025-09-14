//
//  RyzeNavigationView.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/04/25.
//

@_exported import SwiftUI

public struct RyzeNavigationView<Content: View, Route: RyzeRoutable>: View {
    @Namespace var transitionNamespace
    
    @Binding var router: RyzeRouter<Route>
    private let content: () -> Content
    private let destination: (Route) -> any View

    public init(
        router: Binding<RyzeRouter<Route>>,
        destination: @escaping (Route) -> any View,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = router
        self.destination = destination
        self.content = content
    }
    
    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            content()
                .navigationDestination(for: Route.self) {
                    router
                        .makeView(
                            for: $0,
                            content: destination
                        )
                        #if os(iOS)
                        .navigationTransition(.zoom(sourceID: "zoom", in: transitionNamespace))
                        #endif
                }
        }
        .sheet(item: $router.presentRoute) {
            router.makeView(for: $0, content: destination)
        }
        #if os(iOS)
        .fullScreenCover(item: $router.fullRoute) {
            router.makeView(for: $0, content: destination)
        }
        #endif
    }
}
