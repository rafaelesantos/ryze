//
//  RefdsDefaultTheme.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

import SwiftUI

struct RefdsDefaultTheme: RefdsThemeProtocol {
    var font: RefdsFontProtocol
    var color: RefdsColorProtocol
    var spacing: RefdsSpacingProtocol
    var radius: RefdsRadiusProtocol
    var glassmorphic: RefdsGlassmorphicProtocol
    var animation: Animation?
    var feedback: SensoryFeedback
    
    init(
        font: RefdsFontProtocol = RefdsDefaultFont(),
        color: RefdsColorProtocol = RefdsDefaultColor(),
        spacing: RefdsSpacingProtocol = RefdsDefaultSpacing(),
        radius: RefdsRadiusProtocol = RefdsDefaultRadius(),
        glassmorphic: RefdsGlassmorphicProtocol = RefdsDefaultGlassmorphic(),
        animation: Animation? = .interactiveSpring,
        feedback: SensoryFeedback = .impact
    ) {
        self.font = font
        self.color = color
        self.spacing = spacing
        self.radius = radius
        self.glassmorphic = glassmorphic
        self.animation = animation
        self.feedback = feedback
    }
}
