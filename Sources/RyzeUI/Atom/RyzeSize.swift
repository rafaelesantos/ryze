//
//  RyzeSize.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI

public protocol RyzeSizeProtocol {
    var ultraSmall: CGFloat { get }
    var ultraSmall2: CGFloat { get }
    var extraSmall: CGFloat { get }
    var extraSmall2: CGFloat { get }
    var small: CGFloat { get }
    var small2: CGFloat { get }
    var medium: CGFloat { get }
    var medium2: CGFloat { get }
    var large: CGFloat { get }
    var large2: CGFloat { get }
    var extraLarge: CGFloat { get }
    var extraLarge2: CGFloat { get }
    var ultraLarge: CGFloat { get }
    var max: CGFloat { get }
}

public indirect enum RyzeSize {
    case none
    case ultraSmall
    case ultraSmall2
    case extraSmall
    case extraSmall2
    case small
    case small2
    case medium
    case medium2
    case large
    case large2
    case extraLarge
    case extraLarge2
    case ultraLarge
    case max
    
    func rawValue(for theme: RyzeSizeProtocol) -> CGFloat? {
        switch self {
        case .none: return nil
        case .ultraSmall: return theme.ultraSmall
        case .ultraSmall2: return theme.ultraSmall2
        case .extraSmall: return theme.extraSmall
        case .extraSmall2: return theme.extraSmall2
        case .small: return theme.small
        case .small2: return theme.small2
        case .medium: return theme.medium
        case .medium2: return theme.medium2
        case .large: return theme.large
        case .large2: return theme.large2
        case .extraLarge: return theme.extraLarge
        case .extraLarge2: return theme.extraLarge2
        case .ultraLarge: return theme.ultraLarge
        case .max: return theme.max
        }
    }
}
