//
//  RefdsRoutable.swift
//  Refds
//
//  Created by Rafael Escaleira on 03/04/25.
//

@_exported import SwiftUI

public protocol RefdsRoutable: Hashable, Identifiable, Sendable {
    var navigationStyle: RefdsNavigationStyle { get }
    func makeView(for router: RefdsRouter<Self>) -> AnyView
}

extension RefdsRoutable {
    public var id: Self {
        self
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
