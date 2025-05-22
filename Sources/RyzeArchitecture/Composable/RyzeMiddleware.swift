//
//  RyzeMiddleware.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

@_exported import RyzeFoundation

public protocol RyzeMiddleware: Sendable {
    func run(
        state: RyzeState,
        action: RyzeAction
    ) async -> AsyncThrowingStream<RyzeAction, Error>
}

public class RyzeMiddlewares {
    private var middlewares: [RyzeMiddleware] = []
    
    public init() {}
    
    public func use<Middleware: RyzeMiddleware>(_ middleware: @Sendable @escaping () -> Middleware) -> RyzeMiddlewares {
        middlewares.append(middleware())
        return self
    }
    
    func get() -> [RyzeMiddleware] {
        middlewares
    }
}
