//
//  RyzeSection.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI

public struct RyzeSection<Header: View, Content: View, Footer: View>: View {
    let header: Header
    let content: Content
    let footer: Footer
    
    public init(
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.header = header()
        self.content = content()
        self.footer = footer()
    }
    
    public var body: some View {
        Section {
            content
        } header: {
            header.headerProminence(.increased)
        } footer: {
            footer
        }
    }
}

public extension RyzeSection where Header == EmptyView, Content : View, Footer == EmptyView {
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.header = EmptyView()
        self.footer = EmptyView()
    }
}
