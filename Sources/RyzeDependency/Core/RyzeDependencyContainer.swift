//
//  RyzeInjectionValues.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

public actor RyzeDependencyContainer {
    private static var dependencies: [String: Any] = [:]
    
    @discardableResult public static func register<T>(
        for type: T.Type,
        dependency: @Sendable @escaping () -> T
    ) -> RyzeDependencyContainer.Type {
        let id = String(describing: type)
        dependencies[id] = dependency()
        return RyzeDependencyContainer.self
    }
    
    public static func resolve<T>(for type: T.Type) -> T {
        let id = String(describing: type)
        guard let dependency = dependencies[id] as? T else {
            RyzeDependencyError.unregisteredDependencyDescription(id).log()
            fatalError()
        }
        return dependency
    }
    
    public static func checkDependencyRegistered<T>(for type: T.Type) -> Bool {
        let dependency = dependencies["\(type)"] as? T
        return dependency != nil
    }
}
