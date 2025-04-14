//
//  RefdsReducer.swift
//  Refds
//
//  Created by Rafael Escaleira on 12/04/25.
//

public protocol RefdsReducer: Sendable {
    associatedtype State: RefdsState
    func reduce(
        state: State,
        action: RefdsAction
    ) async -> State
}
