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
