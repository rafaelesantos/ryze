//
//  RyzeList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/06/25.
//

@_exported import SwiftUI

public struct RyzeList<SelectionValue: Hashable>: RyzeView {
    let content: any View
    let selection: Binding<Set<SelectionValue>>?
    
    public init(
        selection: Binding<Set<SelectionValue>>? = nil,
        @ViewBuilder content: () -> some View
    ) {
        self.content = content()
        self.selection = selection
    }
    
    public var body: some View {
        List(selection: selection) {
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

public extension RyzeList where SelectionValue == Never {
    init(@ViewBuilder content: () -> some View) {
        self.content = content()
        self.selection = nil
    }
    
    static var mock: some View {
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
