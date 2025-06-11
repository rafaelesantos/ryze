//
//  RyzeTheme.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public protocol RyzeThemeProtocol {
    var font: RyzeFontProtocol { get }
    var color: RyzeColorProtocol { get }
    var spacing: RyzeSpacingProtocol { get }
    var radius: RyzeRadiusProtocol { get }
    var size: RyzeSizeProtocol { get }
    var glassmorphic: RyzeGlassmorphicProtocol { get }
    var locale: RyzeLocale { get }
    var animation: Animation? { get }
    var transition: AnyTransition { get }
    var feedback: SensoryFeedback { get }
    var colorScheme: ColorScheme? { get }
}
