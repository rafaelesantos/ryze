//
//  RefdsMiddleware.swift
//  Refds
//
//  Created by Rafael Escaleira on 12/04/25.
//

@_exported import RefdsFoundation

public protocol RefdsMiddleware: Sendable {
    func run(
        state: RefdsState,
        action: RefdsAction
    ) async -> AsyncThrowingStream<RefdsAction, Error>
}

public class RefdsMiddlewares {
    private var middlewares: [RefdsMiddleware] = []
    
    public init() {}
    
    public func use<Middleware: RefdsMiddleware>(_ middleware: @Sendable @escaping () -> Middleware) -> RefdsMiddlewares {
        middlewares.append(middleware())
        return self
    }
    
    func get() -> [RefdsMiddleware] {
        middlewares
    }
}
