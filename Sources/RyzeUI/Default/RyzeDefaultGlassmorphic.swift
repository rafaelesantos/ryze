//
//  RyzeDefaultGlassmorphic.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

import SwiftUI

struct RyzeDefaultGlassmorphic: RyzeGlassmorphicProtocol {
    var period: TimeInterval
    var colors: [Color]
    var blurRadius: CGFloat
    
    init(
        period: TimeInterval = 6,
        colors: [Color] = [
            Color(#colorLiteral(red: 0, green: 0.5199999809265137, blue: 1, alpha: 1)),
            Color(#colorLiteral(red: 0.2156862745, green: 1, blue: 0.8588235294, alpha: 1)),
            Color(#colorLiteral(red: 1, green: 0.4196078431, blue: 0.4196078431, alpha: 1)),
            Color(#colorLiteral(red: 1, green: 0.1843137255, blue: 0.6745098039, alpha: 1)),
            Color(#colorLiteral(red: 0, green: 0.5199999809265137, blue: 1, alpha: 1))
        ],
        blurRadius: CGFloat = 20
    ) {
        self.period = period
        self.colors = colors
        self.blurRadius = blurRadius
    }
}
