//
//  RefdsInjectionValues.swift
//  Refds
//
//  Created by Rafael Escaleira on 24/03/25.
//

public actor RefdsDependencyContainer {
    private static var dependencies: [String: Any] = [:]
    
    @discardableResult public static func register<T>(
        for type: T.Type,
        dependency: @Sendable @escaping () -> T
    ) -> RefdsDependencyContainer.Type {
        let id = String(describing: type)
        dependencies[id] = dependency()
        return RefdsDependencyContainer.self
    }
    
    public static func resolve<T>(for type: T.Type) -> T {
        let id = String(describing: type)
        guard let dependency = dependencies[id] as? T else {
            RefdsDependencyError.unregisteredDependencyDescription(id).log()
            fatalError()
        }
        return dependency
    }
    
    public static func checkDependencyRegistered<T>(for type: T.Type) -> Bool {
        let dependency = dependencies["\(type)"] as? T
        return dependency != nil
    }
}
