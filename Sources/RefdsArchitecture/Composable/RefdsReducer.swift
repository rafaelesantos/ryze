//
//  RefdsReducer.swift
//  Refds
//
//  Created by Rafael Escaleira on 12/04/25.
//

public protocol RefdsReducer: Sendable {
    func reduce<State, Action>(
        state: State,
        action: Action
    ) async -> State where State: RefdsState, Action: RefdsAction
}
