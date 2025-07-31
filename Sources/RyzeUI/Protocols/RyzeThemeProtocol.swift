//
//  RyzeTheme.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public protocol RyzeThemeProtocol: Sendable {
    var color: RyzeColorProtocol { get set }
    var spacing: RyzeSpacingProtocol { get set }
    var radius: RyzeRadiusProtocol { get set }
    var size: RyzeSizeProtocol { get set }
    var locale: RyzeLocale { get set }
    var animation: Animation? { get set }
    var feedback: SensoryFeedback { get set }
    var colorScheme: ColorScheme? { get set }
}
