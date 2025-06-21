//
//  RyzeInjected.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

@propertyWrapper
public struct RyzeInjected<T> {
    var dependency: T
    
    public var wrappedValue: T {
        dependency
    }
    
    public init() {
        dependency = RyzeDependency.resolve(for: T.self)
    }
}
