//
//  RyzeButton.swift
//  Ryze
//
//  Created by Rafael Escaleira on 18/06/25.
//

@_exported import SwiftUI

public struct RyzeButton: View {
    let action: () -> Void
    let label: any View
    
    public init(
        action: @escaping () -> Void,
        label: () -> some View
    ) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(role: .destructive, action: action) {
            AnyView(label)
        }
        .buttonStyle(.glass)
    }
}

#Preview {
    RyzeButton {
        
    } label: {
        Image(systemName: "wifi")
    }
}
