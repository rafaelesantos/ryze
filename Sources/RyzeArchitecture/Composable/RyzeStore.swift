//
//  RyzeStore.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

@_exported import SwiftUI

@Observable
public final class RyzeStore<Reducer: RyzeReducer, Middleware: RyzeMiddleware> {
    var state: Reducer.State
    var reducer: Reducer
    var middleware: Middleware
    
    public init(
        state: Reducer.State,
        reducer: Reducer,
        middleware: Middleware
    ) {
        self.state = state
        self.reducer = reducer
        self.middleware = middleware
    }
}

public extension RyzeStore where
Reducer.State == Middleware.State,
Reducer.Action == Middleware.Action {
    func dispatch(action: Reducer.Action) async throws {
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
    func mainDispatch(action: Reducer.Action) {
        Task { @MainActor in
            try await dispatch(action: action)
        }
    }
}

