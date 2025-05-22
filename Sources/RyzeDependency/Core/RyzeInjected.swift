//
//  RyzeInjected.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

@propertyWrapper
public struct RyzeInjected<T> {
    private var dependency: T
    
    public var wrappedValue: T { dependency }
    
    public init() {
        dependency = RyzeDependencyContainer.resolve(for: T.self)
    }
}
