//
//  RyzeSecondaryButton.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/07/25.
//

@_exported import SwiftUI

public struct RyzeSecondaryButton: RyzeView {
    @Environment(\.ryzeTheme) var theme
    
    let text: String?
    let role: ButtonRole?
    let action: () -> Void
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ text: String?,
        _ accessibility: RyzeAccessibility? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.accessibility = accessibility
        self.role = role
        self.action = action
    }
    
    public init(
        _ localized: RyzeResourceString?,
        _ accessibility: RyzeAccessibility? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.text = localized?.value
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
            RyzeText(text)
        }
        .ryze(tint: tint)
        .buttonStyle(.bordered)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .glassEffect(.regular.interactive())
    }
    
    public static var mock: some View {
        RyzeSecondaryButton(
            .ryzePreviewTitle,
            role: .cancel
        ) {
            
        }
        .ryze(font: .body)
    }
}

#Preview {
    RyzeSecondaryButton.mock.ryzePadding()
}
