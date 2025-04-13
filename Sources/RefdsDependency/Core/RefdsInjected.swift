//
//  RefdsInjected.swift
//  Refds
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

@propertyWrapper
public struct RefdsInjected<T> {
    private var dependency: T
    
    public var wrappedValue: T { dependency }
    
    public init() {
        dependency = RefdsDependencyContainer.resolve(for: T.self)
    }
}
