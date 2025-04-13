//
//  RefdsMiddleware.swift
//  Refds
//
//  Created by Rafael Escaleira on 12/04/25.
//

public protocol RefdsMiddleware: Sendable {
    func run<State>(
        state: State,
        action: RefdsAction
    ) async -> AsyncStream<RefdsAction> where State: RefdsState
}

public actor RefdsMiddlewares: Sendable {
    private var middlewares: [RefdsMiddleware] = []
    
    public init() {}
    
    public func use<Middleware: RefdsMiddleware>(_ middleware: @Sendable @escaping () async -> Middleware) async {
        await middlewares.append(middleware())
    }
    
    func get() -> [RefdsMiddleware] {
        middlewares
    }
}
