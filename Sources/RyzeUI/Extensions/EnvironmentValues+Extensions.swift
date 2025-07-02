//
//  EnvironmentValues+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public extension EnvironmentValues {
    @Entry var ryzeNamespace: Namespace.ID = Namespace().wrappedValue
    @Entry var ryzeBundle: RyzeBundle = RyzeBundle()
    @Entry var ryzeLoading: Bool = false
    @Entry var ryzeDisabled: Bool = false
    @Entry var ryzeTheme: RyzeThemeProtocol = RyzeDefaultTheme()
    @Entry var ryzeLogger: Logger = Logger()
}
