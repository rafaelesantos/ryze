//
//  RefdsNavigationView.swift
//  Refds
//
//  Created by Rafael Escaleira on 05/04/25.
//

@_exported import SwiftUI

public struct RefdsNavigationView<Content: View, Route: RefdsRoutable>: View {
    @Binding var router: RefdsRouter<Route>
    private let content: (RefdsRouter<Route>) -> Content
    
    public init(
        router: Binding<RefdsRouter<Route>>,
        @ViewBuilder content: @escaping (RefdsRouter<Route>) -> Content
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
        .refdsFull(item: $router.fullRoute) {
            router.makeView(for: $0)
        }
    }
}
