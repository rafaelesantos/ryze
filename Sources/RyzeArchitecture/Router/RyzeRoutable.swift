//
//  RyzeRoutable.swift
//  Ryze
//
//  Created by Rafael Escaleira on 03/04/25.
//

@_exported import SwiftUI

public protocol RyzeRoutable: Hashable, Identifiable {
    associatedtype Content: View
    var navigationStyle: RyzeNavigationStyle { get }
    var body: Content { get }
}

extension RyzeRoutable {
    public var id: Self {
        self
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
