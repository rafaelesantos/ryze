//
//  RyzeDependency.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

public struct RyzeDependency: @unchecked Sendable {
    nonisolated(unsafe) private static var dependencies: [ObjectIdentifier: Any] = [:]
    
    @discardableResult
    public static func register<T>(
        for type: T.Type,
        dependency: @Sendable @escaping () throws -> T
    ) throws -> RyzeDependency.Type {
        let id = ObjectIdentifier(type)
        dependencies[id] = try dependency()
        return RyzeDependency.self
    }
    
    public static func resolve<T>(for type: T.Type) -> T {
        let id = ObjectIdentifier(type)
        guard let dependency = dependencies[id] as? T else {
            let error = RyzeDependencyError.unregisteredDependencyDescription(id.debugDescription)
            fatalError(error.description)
        }
        return dependency
    }
}
