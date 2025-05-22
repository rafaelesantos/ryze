//
//  RyzeRoutable.swift
//  Ryze
//
//  Created by Rafael Escaleira on 03/04/25.
//

@_exported import SwiftUI

public protocol RyzeRoutable: Hashable, Identifiable, Sendable {
    var navigationStyle: RyzeNavigationStyle { get }
    func makeView(for router: RyzeRouter<Self>) -> AnyView
}

extension RyzeRoutable {
    public var id: Self {
        self
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
