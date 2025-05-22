//
//  RyzeShape.swift
//  Ryze
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI

public struct RyzeShape: Shape {
    private var base: @Sendable (CGRect) -> Path
    
    public init<S: Shape>(shape: S) {
        base = shape.path(in:)
    }
    
    public func path(in rect: CGRect) -> Path {
        base(rect)
    }
}
