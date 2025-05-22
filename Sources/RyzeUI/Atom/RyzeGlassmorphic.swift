//
//  RyzeGlassmorphism.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

public protocol RyzeGlassmorphicProtocol {
    var period: TimeInterval { get }
    var colors: [Color] { get }
    var blurRadius: CGFloat { get }
}
