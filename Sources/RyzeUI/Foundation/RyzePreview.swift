//
//  RyzePreview.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public struct RyzePreview<Content: View>: View {
    let colorSchemes: [ColorScheme] = [.light, .dark]
    let locales: [RyzeLocale] = [.portugueseBR, .englishUS]
    let orientations: [InterfaceOrientation] = [.portrait, .landscapeRight]
    let layouts: [PreviewLayout] = [.sizeThatFits, .device]
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        Group {
            ForEach(locales.indices, id: \.self) {
                let locale = locales[$0]
                ForEach(orientations.indices, id: \.self) {
                    let orientation = orientations[$0]
                    ForEach(layouts.indices, id: \.self) {
                        let layout = layouts[$0]
                        ForEach(colorSchemes.indices, id: \.self) {
                            let colorScheme = colorSchemes[$0]
                            content
                                .ryzePreview(
                                    layout: layout,
                                    orientation: orientation,
                                    colorScheme: colorScheme,
                                    locale: locale
                                )
                        }
                    }
                }
            }
        }
    }
}
