//
//  RyzeButton.swift
//  Ryze
//
//  Created by Rafael Escaleira on 18/06/25.
//

@_exported import SwiftUI

public struct RyzeButton: RyzeView {
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
        Button {
            action()
        } label: {
            AnyView(label)
        }
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
