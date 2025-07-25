//
//  RyzeButton.swift
//  Ryze
//
//  Created by Rafael Escaleira on 18/06/25.
//

@_exported import SwiftUI

public struct RyzeButton: RyzeView {
    let role: ButtonRole?
    let action: () -> Void
    let label: any View
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ accessibility: RyzeAccessibility? = nil,
        role: ButtonRole? = .none,
        action: @escaping () -> Void,
        label: () -> some View
    ) {
        self.accessibility = accessibility
        self.role = role
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(role: role) {
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
