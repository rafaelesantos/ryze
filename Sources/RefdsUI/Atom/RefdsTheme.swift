//
//  RefdsTheme.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public protocol RefdsThemeProtocol {
    var font: RefdsFontProtocol { get }
    var color: RefdsColorProtocol { get }
    var spacing: RefdsSpacingProtocol { get }
    var radius: RefdsRadiusProtocol { get }
    var glassmorphic: RefdsGlassmorphicProtocol { get }
    var animation: Animation? { get }
    var feedback: SensoryFeedback { get }
}
