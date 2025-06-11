//
//  RyzeColor.swift
//  Ryze
//
//  Created by Rafael Escaleira on 18/04/25.
//

@_exported import SwiftUI

public protocol RyzeColorProtocol {
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
}

public enum RyzeColor: CaseIterable, Equatable {
    case primary
    case secondary
    case background
    case backgroundSecondary
    case shadow
    case surface
    case text
    case textSecondary
    case border
    case error
    case success
    case warning
    case info
    case disabled
    case hover
    case pressed
    case white
    case black
    
    func rawValue(for theme: RyzeColorProtocol) -> Color {
        switch self {
        case .primary: return theme.primary
        case .secondary: return theme.secondary
        case .background: return theme.background
        case .backgroundSecondary: return theme.backgroundSecondary
        case .shadow: return theme.shadow
        case .surface: return theme.surface
        case .text: return theme.text
        case .textSecondary: return theme.textSecondary
        case .border: return theme.border
        case .error: return theme.error
        case .success: return theme.success
        case .warning: return theme.warning
        case .info: return theme.info
        case .disabled: return theme.disabled
        case .hover: return theme.hover
        case .pressed: return theme.pressed
        case .white: return .white
        case .black: return .black
        }
    }
}
