//
//  RyzeDefaultTheme.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

import SwiftUI

struct RyzeDefaultTheme: RyzeThemeProtocol {
    var font: RyzeFontProtocol
    var color: RyzeColorProtocol
    var spacing: RyzeSpacingProtocol
    var radius: RyzeRadiusProtocol
    var glassmorphic: RyzeGlassmorphicProtocol
    var animation: Animation?
    var feedback: SensoryFeedback
    
    init(
        font: RyzeFontProtocol = RyzeDefaultFont(),
        color: RyzeColorProtocol = RyzeDefaultColor(),
        spacing: RyzeSpacingProtocol = RyzeDefaultSpacing(),
        radius: RyzeRadiusProtocol = RyzeDefaultRadius(),
        glassmorphic: RyzeGlassmorphicProtocol = RyzeDefaultGlassmorphic(),
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
