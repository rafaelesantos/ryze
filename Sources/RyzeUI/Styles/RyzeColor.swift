//
//  RyzeColor.swift
//  Ryze
//
//  Created by Rafael Escaleira on 01/07/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeColor: ShapeStyle, @unchecked Sendable {
    private let keyPath: KeyPath<RyzeColorProtocol, Color>
    
    init(keyPath: KeyPath<RyzeColorProtocol, Color>) {
        self.keyPath = keyPath
    }
    
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        environment.ryzeTheme.color[keyPath: keyPath]
    }
}
