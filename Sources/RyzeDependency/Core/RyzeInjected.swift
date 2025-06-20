//
//  RyzeInjected.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

@MainActor
@propertyWrapper
public struct RyzeInjected<T: Sendable> {
    private var dependency: T
    
    public var wrappedValue: T { dependency }
    
    public init() async {
        dependency = await RyzeDependencyContainer.shared.resolve(for: T.self)
    }
}
