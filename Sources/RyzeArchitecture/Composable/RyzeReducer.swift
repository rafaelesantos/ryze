//
//  RyzeReducer.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

public protocol RyzeReducer: Sendable {
    associatedtype State: RyzeState
    associatedtype Action: RyzeAction
    
    func reduce(
        state: State,
        action: Action
    ) async -> State
}
