//
//  RyzeMiddleware.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

@_exported import RyzeFoundation

public protocol RyzeMiddleware: Sendable {
    associatedtype State: RyzeState
    associatedtype Action: RyzeAction
    
    func run(
        state: State,
        action: Action
    ) async -> AsyncStream<Action>
}
