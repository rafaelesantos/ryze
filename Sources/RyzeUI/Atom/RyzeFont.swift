//
//  RyzeFont.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public protocol RyzeFontProtocol {
    var largeTitle: Font { get }
    var title: Font { get }
    var title2: Font { get }
    var title3: Font { get }
    var headline: Font { get }
    var subheadline: Font { get }
    var body: Font { get }
    var callout: Font { get }
    var footnote: Font { get }
    var caption: Font { get }
}

public enum RyzeFont: CaseIterable, Equatable {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case footnote
    case caption
    
    func rawValue(for theme: RyzeFontProtocol) -> Font {
        switch self {
        case .largeTitle: return theme.largeTitle
        case .title: return theme.title
        case .title2: return theme.title2
        case .title3: return theme.title3
        case .headline: return theme.headline
        case .subheadline: return theme.subheadline
        case .body: return theme.body
        case .callout: return theme.callout
        case .footnote: return theme.footnote
        case .caption: return theme.caption
        }
    }
}
