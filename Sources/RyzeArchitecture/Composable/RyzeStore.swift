//
//  RyzeStore.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

@Observable
public class RyzeStore<Reducer: RyzeReducer> {
    public var state: Reducer.State
    public var reducer: Reducer
    public var middlewares: RyzeMiddlewares
    
    public init(
        state: Reducer.State,
        reducer: Reducer,
        middlewares: RyzeMiddlewares
    ) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    @MainActor
    public func dispatch(action: RyzeAction) async throws {
        state = await reducer.reduce(
            state: state,
            action: action
        )
        
        for middleware in middlewares.get() {
            let actions = await middleware.run(
                state: state,
                action: action
            )
            
            for try await action in actions {
                try await dispatch(action: action)
            }
        }
    }
}

