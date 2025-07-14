//
//  RyzeBodyText.swift
//  Ryze
//
//  Created by Rafael Escaleira on 03/07/25.
//

@_exported import SwiftUI

public struct RyzeBodyText: RyzeView {
    let text: String?
    let weight: Font.Weight?
    let design: Font.Design?
    public var accessibility: RyzeAccessibility?
    
    
    public init(
        _ localized: RyzeResourceString?,
        _ accessibility: RyzeAccessibility? = nil,
        weight: Font.Weight? = nil,
        design: Font.Design? = nil
    ) {
        self.text = localized?.value
        self.accessibility = accessibility
        self.weight = weight
        self.design = design
    }
    
    public var body: some View {
        RyzeText(
            text,
            accessibility,
            font: .body,
            weight: weight,
            design: design,
            color: .text
        )
    }
    
    public static var mock: some View {
        RyzeBodyText(RyzeUIString.ryzePreviewDescription)
    }
}

#Preview {
    RyzeBodyText.mock.ryzePadding()
}
