//
//  RyzeView.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/06/25.
//

@_exported import SwiftUI

public protocol RyzeView: View, RyzeUIMock {
    var accessibility: RyzeAccessibility? { get }
    var canAppear: Bool { get }
}

public extension RyzeView {
    var accessibility: RyzeAccessibility? { nil }
    var canAppear: Bool { true }
}
