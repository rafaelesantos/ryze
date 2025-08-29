//
//  Array+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/08/25.
//

import Foundation

public extension Array {
    func asyncMap<T>(
        _ transform: @escaping (Element) async -> T
    ) async -> [T] {
        var results = [T]()
        for item in self {
            await results.append(transform(item))
        }
        return results
    }
    
    func asyncCompactMap<T>(
        _ transform: @escaping (Element) async -> T?
    ) async -> [T] {
        var results = [T]()
        for item in self {
            if let transformed = await transform(item) {
                results.append(transformed)
            }
        }
        return results
    }
    
    func asyncFilter(
        _ transform: @escaping (Element) async -> Bool
    ) async -> [Element] {
        var results = [Element]()
        for item in self {
            if await transform(item) {
                results.append(item)
            }
        }
        return results
    }
}
