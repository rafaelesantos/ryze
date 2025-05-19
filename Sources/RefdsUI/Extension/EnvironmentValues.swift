//
//  EnvironmentValues.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public extension EnvironmentValues {
    @Entry var refdsTheme: RefdsThemeProtocol = {
        RefdsDefaultTheme()
    }()
}
