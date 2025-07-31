//
//  RyzeList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/06/25.
//

@_exported import SwiftUI

public struct RyzeList: RyzeView {
    let content: any View
    
    public init(@ViewBuilder content: () -> some View) {
        self.content = content()
    }
    
    public var body: some View {
        List {
            AnyView(content)
        }
    }
    
    public static var mock: some View {
        RyzeList {
            RyzeBodyText.mock
            RyzePrimaryButton.mock
            RyzeSection.mock
            RyzeFootnoteText.mock
            RyzeSecondaryButton.mock
        }
    }
}

#Preview {
    RyzeList.mock
}
