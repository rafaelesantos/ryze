//
//  RyzeText.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

import SwiftUI

public struct RyzeText: RyzeView {
    @Environment(\.ryzeLoading) private var isLoading
    
    let text: String?
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ localized: RyzeResourceString?,
        _ accessibility: RyzeAccessibility? = nil,
    ) {
        self.text = localized?.value
        self.accessibility = accessibility
    }
    
    public init(
        _ text: String?,
        _ accessibility: RyzeAccessibility? = nil,
    ) {
        self.text = text
        self.accessibility = accessibility
    }
    
    @ViewBuilder
    public var body: some View {
        if isLoading {
            Text(text ?? .ryzePreviewDescription)
                .ryzeSkeleton()
        } else if let text {
            Text(text)
                .ryze(accessibility: accessibility)
        }
    }
    
    public static var mock: some View {
        RyzeText(.ryzePreviewDescription)
    }
}

#Preview {
    RyzeText.mock
}
