//
//  RyzeButton.swift
//  Ryze
//
//  Created by Rafael Escaleira on 18/06/25.
//

@_exported import SwiftUI

public struct RyzeButton: RyzeView {
    @Environment(\.theme) var theme
    
    let role: ButtonRole?
    let action: () -> Void
    let label: any View
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ accessibility: RyzeAccessibility? = nil,
        role: ButtonRole? = .none,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> some View
    ) {
        self.accessibility = accessibility
        self.role = role
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(role: role) {
            #if os(iOS)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            #endif
            action()
        } label: {
            AnyView(label)
        }
        .ryze(accessibility: accessibility)
    }
    
    public static var mock: some View {
        RyzeButton {
            
        } label: {
            RyzeText.mock
        }
    }
}

#Preview {
    RyzeButton.mock
}
