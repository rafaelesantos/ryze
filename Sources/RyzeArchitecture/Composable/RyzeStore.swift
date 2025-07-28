//
//  RyzeStore.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

@_exported import SwiftUI

public protocol RyzeStore: ObservableObject {
    associatedtype State: RyzeState
    associatedtype Action: RyzeAction
    associatedtype Reducer: RyzeReducer
    associatedtype Middleware: RyzeMiddleware
    
    var state: State { get set }
    var reducer: Reducer { get }
    var middleware: Middleware { get }
    
    func dispatch(action: Action) async throws
}

public extension RyzeStore where Self: AnyObject, State == Reducer.State, Action == Reducer.Action, State == Middleware.State, Action == Middleware.Action {
    
    @MainActor
    func dispatch(action: Action) {
        Task { @MainActor in
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
    }
}

