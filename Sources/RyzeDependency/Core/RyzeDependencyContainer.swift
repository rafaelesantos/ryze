//
//  RyzeInjectionValues.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

public actor RyzeDependencyContainer: Sendable {
    public static let shared = RyzeDependencyContainer()
    
    private var dependencies: [ObjectIdentifier: Any] = [:]
    
    @discardableResult public func register<T>(
        for type: T.Type,
        dependency: @Sendable @escaping () -> T
    ) -> RyzeDependencyContainer.Type {
        let id = ObjectIdentifier(type)
        dependencies[id] = dependency()
        return RyzeDependencyContainer.self
    }
    
    public func resolve<T>(for type: T.Type) -> T {
        let id = ObjectIdentifier(type)
        guard let dependency = dependencies[id] as? T else {
            RyzeDependencyError.unregisteredDependencyDescription(id.debugDescription).log()
            fatalError()
        }
        return dependency
    }
    
    public func checkDependencyRegistered<T>(for type: T.Type) -> Bool {
        let id = ObjectIdentifier(type)
        let dependency = dependencies[id] as? T
        return dependency != nil
    }
}
