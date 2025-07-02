//
//  RyzeFont.swift
//  Ryze
//
//  Created by Rafael Escaleira on 01/07/25.
//

@_exported import SwiftUI

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
