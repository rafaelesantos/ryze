//
//  RyzeInjectionValues.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

public actor RyzeDependencyContainer: @unchecked Sendable {
    public static let shared = RyzeDependencyContainer()
    
    private var dependencies: [ObjectIdentifier: Any] = [:]
    
    @discardableResult public func register<T>(
        for type: T.Type,
        dependency: @Sendable @escaping () async throws -> T
    ) async throws -> RyzeDependencyContainer.Type {
        let id = ObjectIdentifier(type)
        dependencies[id] = try await dependency()
        return RyzeDependencyContainer.self
    }
    
    public func resolve<T>(for type: T.Type) async throws -> T {
        let id = ObjectIdentifier(type)
        guard let dependency = dependencies[id] as? T else {
            throw RyzeDependencyError.unregisteredDependencyDescription(id.debugDescription)
        }
        return dependency
    }
}
