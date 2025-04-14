//
//  RefdsStore.swift
//  Refds
//
//  Created by Rafael Escaleira on 12/04/25.
//

@MainActor
@Observable
public class RefdsStore<Reducer: RefdsReducer> {
    public var state: Reducer.State
    public var reducer: Reducer
    public var middlewares: RefdsMiddlewares
    
    public init(
        state: Reducer.State,
        reducer: Reducer,
        middlewares: RefdsMiddlewares
    ) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    public func dispatch(action: RefdsAction) async {
        state = await reducer.reduce(
            state: state,
            action: action
        )
        
        for middleware in await middlewares.get() {
            let actions = await middleware.run(
                state: state,
                action: action
            )
            
            for await action in actions {
                await dispatch(action: action)
            }
        }
    }
}

