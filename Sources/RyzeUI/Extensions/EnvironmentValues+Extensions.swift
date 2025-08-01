//
//  EnvironmentValues+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public extension EnvironmentValues {
    @Entry var isLoading: Bool = false
    @Entry var isDisabled: Bool = false
    @Entry var screenSize: CGSize = .zero
    @Entry var scrollPosition: CGPoint = .zero
    @Entry var isLargeScreen: Bool = false
    
    @Entry var theme: RyzeThemeProtocol = RyzeDefaultTheme()
}
