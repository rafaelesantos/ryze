//
//  RyzePrimaryButton.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/06/25.
//

@_exported import SwiftUI

public struct RyzePrimaryButton: RyzeView {
    @Environment(\.ryzeTheme) var theme
    
    let localized: RyzeResourceString?
    let role: ButtonRole?
    let action: () -> Void
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ localized: RyzeResourceString?,
        _ accessibility: RyzeAccessibility? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.localized = localized
        self.accessibility = accessibility
        self.role = role
        self.action = action
    }
    
    var tint: RyzeColor {
        switch role {
        case .destructive: return .error
        default: return .primary
        }
    }
    
    public var body: some View {
        RyzeButton(
            accessibility,
            role: role,
            action: action
        ) {
            RyzeText(localized)
        }
        .ryze(tint: tint)
        .buttonStyle(.glassProminent)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
    }
    
    public static var mock: some View {
        RyzePrimaryButton(RyzeUIString.coffeeDrivenTitle, role: .cancel) {
            
        }
    }
}

#Preview {
    RyzePrimaryButton.mock.ryzePadding()
}
