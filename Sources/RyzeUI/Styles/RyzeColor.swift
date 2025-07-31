//
//  RyzeColor.swift
//  Ryze
//
//  Created by Rafael Escaleira on 01/07/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeColor: ShapeStyle, @unchecked Sendable {
    private enum Storage {
        case themed(KeyPath<RyzeColorProtocol, Color>)
        case custom(Color)
    }
    
    private let storage: Storage
    
    init(keyPath: KeyPath<RyzeColorProtocol, Color>) {
        self.storage = .themed(keyPath)
    }
    
    public init(rawValue: Color) {
        self.storage = .custom(rawValue)
    }
    
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        switch storage {
        case .themed(let keyPath):
            return environment.theme.color[keyPath: keyPath]
        case .custom(let color):
            return color
        }
    }
}
