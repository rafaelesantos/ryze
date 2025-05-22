//
//  RyzeReducer.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/04/25.
//

public protocol RyzeReducer: Sendable {
    associatedtype State: RyzeState
    func reduce(
        state: State,
        action: RyzeAction
    ) async -> State
}
