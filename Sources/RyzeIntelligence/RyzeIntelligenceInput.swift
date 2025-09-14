//
//  RyzeIntelligenceInput.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/09/25.
//

import CoreML

public final class RyzeIntelligenceInput<T>: MLFeatureProvider {
    var value: T
    var features: [KeyPath<T, Any>]
    var target: KeyPath<T, Any>
    
    public init(value: T, features: [KeyPath<T, Any>], target: KeyPath<T, Any>) {
        self.value = value
        self.features = features
        self.target = target
    }
    
    public var allKeys: Set<KeyPath<T, Any>> {
        Set(features + [target])
    }
    
    public var featureNames: Set<String> {
        Set(allKeys.map { String(describing: $0) })
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        guard let keyPath = allKeys.first(where: { String(describing: $0) == featureName }) else { return nil }
        switch value[keyPath: keyPath] {
        case let value as String: return MLFeatureValue(string: value)
        case let value as Double: return MLFeatureValue(double: value)
        default: return nil
        }
    }
}
