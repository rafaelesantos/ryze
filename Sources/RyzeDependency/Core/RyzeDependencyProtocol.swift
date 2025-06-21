//
//  RyzeDependencyProtocol.swift
//  Ryze
//
//  Created by Rafael Escaleira on 28/03/25.
//

public protocol RyzeDependencyProtocol: Sendable {
    static func registerDependency() async throws
}
