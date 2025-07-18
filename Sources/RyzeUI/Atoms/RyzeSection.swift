//
//  RyzeSection.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzeSection: RyzeView {
    let header: any View
    let content: any View
    let footer: any View
    
    public init(
        @ViewBuilder header: () -> some View,
        @ViewBuilder content: () -> some View,
        @ViewBuilder footer: () -> some View
    ) {
        self.header = header()
        self.content = content()
        self.footer = footer()
    }
    
    public init(@ViewBuilder content: () -> some View) {
        self.content = content()
        self.header = EmptyView()
        self.footer = EmptyView()
    }
    
    public init(
        header: RyzeResourceString? = nil,
        footer: RyzeResourceString? = nil,
        @ViewBuilder content: () -> some View
    ) {
        self.content = content()
        self.header = header == nil ? EmptyView() :
        RyzeText(header)
            .ryze(font: .footnote)
            .ryze(color: .textSecondary)
        
        self.footer = footer == nil ? EmptyView() :
        RyzeText(footer)
            .ryze(font: .footnote)
            .ryze(color: .textSecondary)
    }
    
    public var body: some View {
        Section {
            AnyView(content)
        } header: {
            AnyView(header)
        } footer: {
            AnyView(footer)
        }
    }
    
    public static var mock: some View {
        RyzeSection(
            header: RyzeUIString.ryzePreviewTitle,
            footer: RyzeUIString.ryzePreviewDescription
        ) {
            RyzeBodyText.mock
            RyzeHStack.mock
            RyzeFootnoteText.mock
        }
    }
}

#Preview {
    RyzeSection.mock
}
