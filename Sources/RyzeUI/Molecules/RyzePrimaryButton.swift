//
//  RyzePrimaryButton.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/06/25.
//

@_exported import SwiftUI

public struct RyzePrimaryButton: View {
    let localized: RyzeResourceString?
    let action: () -> Void
    
    public init(
        _ localized: RyzeResourceString?,
        action: @escaping () -> Void
    ) {
        self.localized = localized
        self.action = action
    }
    
    public var body: some View {
        RyzeButton(action: action) {
            RyzeText(localized)
        }
        .buttonStyle(RyzePrimaryButtonStyle())
    }
}
