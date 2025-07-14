//
//  RyzeLabel.swift
//  Ryze
//
//  Created by Rafael Escaleira on 04/07/25.
//

@_exported import SwiftUI

public struct RyzeLabel: RyzeView {
    @Environment(\.ryzeLoading) private var isLoading
    
    let text: String?
    let symbol: String
    
    public var accessibility: RyzeAccessibility?
    
    public init(
        _ text: String?,
        _ accessibility: RyzeAccessibility? = nil,
        symbol: String,
    ) {
        self.text = text
        self.accessibility = accessibility
        self.symbol = symbol
    }
    
    public init(
        _ localized: RyzeResourceString?,
        _ accessibility: RyzeAccessibility? = nil,
        symbol: String,
    ) {
        self.text = localized?.value
        self.accessibility = accessibility
        self.symbol = symbol
    }
    
    public var body: some View {
        if isLoading {
            Label(
                text ?? .ryzePreviewDescription,
                systemImage: symbol
            )
            .ryzeSkeleton()
        } else if let text {
            Label(
                text,
                systemImage: symbol
            )
        }
    }
    
    public static var mock: some View {
        RyzeLabel(
            RyzeUIString.ryzePreviewTitle,
            symbol: "bolt.fill"
        )
    }
}

#Preview {
    RyzeLabel.mock.ryzePadding()
}
