//
//  Array+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/08/25.
//

import Foundation

public extension Array {
    func asyncMap<T>(
        _ transform: @escaping (Element) async throws -> T
    ) async rethrows -> [T] {
        var results = [T]()
        for item in self {
            try await results.append(transform(item))
        }
        return results
    }
    
    func asyncCompactMap<T>(
        _ transform: @escaping (Element) async throws -> T?
    ) async rethrows -> [T] {
        var results = [T]()
        for item in self {
            if let transformed = try await transform(item) {
                results.append(transformed)
            }
        }
        return results
    }
    
    func asyncFilter(
        _ predicate: @escaping (Element) async throws -> Bool
    ) async rethrows -> [Element] {
        var results = [Element]()
        for item in self {
            if try await predicate(item) {
                results.append(item)
            }
        }
        return results
    }
}
