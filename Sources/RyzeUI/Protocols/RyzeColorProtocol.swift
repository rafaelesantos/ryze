//
//  RyzeColorProtocol.swift
//  Ryze
//
//  Created by Rafael Escaleira on 18/04/25.
//

@_exported import SwiftUI

public protocol RyzeColorProtocol: Sendable {
    var primary: Color { get }
    var secondary: Color { get }
    var background: Color { get }
    var backgroundSecondary: Color { get }
    var shadow: Color { get }
    var surface: Color { get }
    var text: Color { get }
    var textSecondary: Color { get }
    var border: Color { get }
    var error: Color { get }
    var success: Color { get }
    var warning: Color { get }
    var info: Color { get }
    var disabled: Color { get }
    var hover: Color { get }
    var pressed: Color { get }
    var white: Color { get }
    var black: Color { get }
}
