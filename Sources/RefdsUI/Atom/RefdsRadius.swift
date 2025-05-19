//
//  RefdsRadius.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public protocol RefdsRadiusProtocol {
    var none: CGFloat { get }
    var small: CGFloat { get }
    var medium: CGFloat { get }
    var large: CGFloat { get }
    var extraLarge: CGFloat { get }
    var circle: CGFloat { get }
}

public enum RefdsRadius: CaseIterable, Equatable {
    case none
    case small
    case medium
    case large
    case extraLarge
    case circle
    case capsule
    
    func rawValue(for theme: RefdsRadiusProtocol) -> CGFloat {
        switch self {
        case .none: return theme.none
        case .small: return theme.small
        case .medium: return theme.medium
        case .large: return theme.large
        case .extraLarge: return theme.extraLarge
        case .circle, .capsule: return theme.circle
        }
    }
}
