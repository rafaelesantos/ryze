//
//  RyzeRouter.swift
//  Ryze
//
//  Created by Rafael Escaleira on 03/04/25.
//

@_exported import SwiftUI

@MainActor
@Observable
public class RyzeRouter<Route: RyzeRoutable> {
    public var navigationPath = NavigationPath()
    public var isPresented: Binding<Route?>
    
    public var presentRoute: Route?
    public var fullRoute: Route?
    
    public var isPresenting: Bool {
        presentRoute != nil ||
        fullRoute != nil
    }
    
    public init(isPresented: Binding<Route?>) {
        self.isPresented = isPresented
    }
    
    public func makeView(for route: Route) -> AnyView {
        router(with: route.navigationStyle)
            .makeView(for: route)
    }
    
    public func route(to destination: Route) {
        switch destination.navigationStyle {
        case .push: push(to: destination)
        case .present: present(to: destination)
        case .full: full(to: destination)
        }
    }
    
    public func root() {
        navigationPath = .init()
    }
    
    public func dismiss() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        } else if presentRoute != nil {
            presentRoute = nil
        } else if fullRoute != nil {
            fullRoute = nil
        } else {
            isPresented.wrappedValue = nil
        }
    }
    
    private func push(to route: Route) {
        navigationPath.append(route)
    }
    
    private func present(to route: Route) {
        presentRoute = route
    }
    
    private func full(to route: Route) {
        self.fullRoute = route
    }
    
    private func router(with style: RyzeNavigationStyle) -> RyzeRouter {
        switch style {
        case .push:
            return self
        case .present:
            return RyzeRouter(
                isPresented: Binding(
                    get: { self.presentRoute },
                    set: { self.presentRoute = $0 }
                )
            )
        case .full:
            return RyzeRouter(
                isPresented: Binding(
                    get: { self.fullRoute },
                    set: { self.fullRoute = $0 }
                )
            )
        }
    }
}
