//
//  RyzeStore.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

@_exported import SwiftUI

@Observable
public final class RyzeStore<State: RyzeState, Action: RyzeAction, Reducer: RyzeReducer, Middleware: RyzeMiddleware> {
    var state: State
    var reducer: Reducer
    var middleware: Middleware
    
    public init(
        state: State,
        reducer: Reducer,
        middleware: Middleware
    ) {
        self.state = state
        self.reducer = reducer
        self.middleware = middleware
    }
}

public extension RyzeStore where
State == Reducer.State,
Action == Reducer.Action,
State == Middleware.State,
Action == Middleware.Action {
    func dispatch(action: Action) async throws {
        state = await reducer.reduce(
            state: state,
            action: action
        )
        
        let actions = await middleware.run(
            state: state,
            action: action
        )
        
        for await action in actions {
            try await dispatch(action: action)
        }
    }
    
    @MainActor
    func mainDispatch(action: Action) {
        Task { @MainActor in
            try await dispatch(action: action)
        }
    }
}

