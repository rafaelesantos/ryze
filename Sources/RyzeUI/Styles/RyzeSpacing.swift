//
//  RyzeSpacing.swift
//  Ryze
//
//  Created by Rafael Escaleira on 01/07/25.
//

@_exported import SwiftUI

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
