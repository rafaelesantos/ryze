//
//  RefdsSpacing.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public protocol RefdsSpacingProtocol {
    var none: CGFloat { get }
    var extraSmall: CGFloat { get }
    var small: CGFloat { get }
    var medium: CGFloat { get }
    var large: CGFloat { get }
    var extraLarge: CGFloat { get }
    var ultraLarge: CGFloat { get }
    var section: CGFloat { get }
}

public indirect enum RefdsSpacing {
    case none
    case extraSmall
    case small
    case medium
    case large
    case extraLarge
    case ultraLarge
    case section
    case negative(RefdsSpacing)
    
    func rawValue(for theme: RefdsSpacingProtocol) -> CGFloat {
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
