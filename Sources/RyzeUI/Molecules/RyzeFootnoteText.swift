//
//  RyzeFootnoteText.swift
//  Ryze
//
//  Created by Rafael Escaleira on 03/07/25.
//

@_exported import SwiftUI

public struct RyzeFootnoteText: RyzeView {
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
            font: .footnote,
            weight: weight,
            design: design,
            color: .textSecondary
        )
    }
    
    public static var mock: some View {
        RyzeFootnoteText(RyzeUIString.ryzePreviewDescription)
    }
}

#Preview {
    RyzeFootnoteText.mock.ryzePadding()
}
