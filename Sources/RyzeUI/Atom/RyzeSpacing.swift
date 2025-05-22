//
//  RyzeSpacing.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public protocol RyzeSpacingProtocol {
    var none: CGFloat { get }
    var extraSmall: CGFloat { get }
    var small: CGFloat { get }
    var medium: CGFloat { get }
    var large: CGFloat { get }
    var extraLarge: CGFloat { get }
    var ultraLarge: CGFloat { get }
    var section: CGFloat { get }
}

public indirect enum RyzeSpacing {
    case none
    case extraSmall
    case small
    case medium
    case large
    case extraLarge
    case ultraLarge
    case section
    case negative(RyzeSpacing)
    
    func rawValue(for theme: RyzeSpacingProtocol) -> CGFloat {
        switch self {
        case .none: return theme.none
        case .extraSmall: return theme.extraSmall
        case .small: return theme.small
        case .medium: return theme.medium
        case .large: return theme.large
        case .extraLarge: return theme.extraLarge
        case .ultraLarge: return theme.ultraLarge
        case .section: return theme.section
        case let .negative(spacing): return -spacing.rawValue(for: theme)
        }
    }
}
