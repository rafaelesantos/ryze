//
//  RyzeInjected.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

@propertyWrapper
public struct RyzeInjected<T: RyzeDependency> {
    private var dependency: T
    
    public var wrappedValue: T {
        dependency
    }
    
    public init() async throws {
        dependency = try await T.resolve()
    }
}
