//
//  RefdsStore.swift
//  Refds
//
//  Created by Rafael Escaleira on 12/04/25.
//

@MainActor
@Observable
public class RefdsStore<State: RefdsState> {
    public var state: State
    public var reducer: any RefdsReducer
    public var middlewares: RefdsMiddlewares
    
    public init(
        state: State,
        reducer: any RefdsReducer,
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

