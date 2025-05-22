//
//  RyzeTheme.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public protocol RyzeThemeProtocol {
    var font: RyzeFontProtocol { get }
    var color: RyzeColorProtocol { get }
    var spacing: RyzeSpacingProtocol { get }
    var radius: RyzeRadiusProtocol { get }
    var glassmorphic: RyzeGlassmorphicProtocol { get }
    var animation: Animation? { get }
    var feedback: SensoryFeedback { get }
}
