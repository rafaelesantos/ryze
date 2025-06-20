//
//  RyzeDependency.swift
//  Ryze
//
//  Created by Rafael Escaleira on 28/03/25.
//

public protocol RyzeDependency {
    static func registerDependency()
    static func resolve() -> Self
}
