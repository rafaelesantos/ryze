//
//  RyzeBodyText.swift
//  Ryze
//
//  Created by Rafael Escaleira on 03/07/25.
//

@_exported import SwiftUI

public struct RyzeBodyText: RyzeView {
    let text: String?
    public var accessibility: RyzeAccessibility?
    
    
    public init(
        _ localized: RyzeResourceString?,
        _ accessibility: RyzeAccessibility? = nil
    ) {
        self.text = localized?.value
        self.accessibility = accessibility
    }
    
    public var body: some View {
        RyzeText(
            text,
            accessibility
        )
        .ryze(font: .body)
        .ryze(color: .text)
    }
    
    public static var mock: some View {
        RyzeBodyText(RyzeUIString.ryzePreviewDescription)
    }
}

#Preview {
    RyzeBodyText.mock.ryzePadding()
}
