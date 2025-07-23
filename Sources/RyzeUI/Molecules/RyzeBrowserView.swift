//
//  RyzeBrowserView.swift
//  Ryze
//
//  Created by Rafael Escaleira on 22/07/25.
//

@_exported import SwiftUI
import SafariServices

public struct RyzeBrowserView<Content: View>: View {
    @Binding private var url: URL?
    let content: Content
    
    public init(
        url: Binding<URL?>,
        @ViewBuilder content: () -> Content
    ) {
        self._url = url
        self.content = content()
    }
    
    public var body: some View {
        content
            .sheet(item: $url) { url in
                RyzeBrowser(url: url)
            }
    }
}

#if canImport(AppKit)

struct RyzeBrowser: NSViewRepresentable {
    let url: URL
    
    func updateNSView(
        _ NSView: NSView,
        context: NSViewRepresentableContext<RyzeBrowser>
    ) {
        NSWorkspace.shared.open(url)
    }
    
    func makeNSView(context: Context) -> NSView {
        return .init()
    }
}

#elseif canImport(UIKit)

struct RyzeBrowser: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        return
    }
    
}

#endif
