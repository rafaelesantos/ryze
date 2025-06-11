//
//  RyzeLazyList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import SwiftUI

public struct RyzeLazyList<Content: View>: View {
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                _VariadicView.Tree(RyzeLazyListLayout()) {
                    content
                }
            }
            .ryzePadding()
        }
    }
    
    struct RyzeLazyListLayout: _VariadicView_MultiViewRoot {
        @ViewBuilder
        func body(children: _VariadicView.Children) -> some View {
            ForEach(children) { child in
                child
                    .ryzePadding(.vertical, spacing: .small)
                    .ryzePadding(.horizontal, spacing: .medium)
            }
        }
    }
}

#Preview {
    RyzeLazyList {
        RyzeText(.ryzePreviewTitle)
        
        RyzeSection {
            Button {} label: {
                RyzeText(.ryzePreviewTitle)
            }
            RyzeText(.ryzePreviewTitle)
            RyzeText(.ryzePreviewTitle)
            RyzeText(.ryzePreviewTitle)
        }
        
        RyzeSection {
            RyzeText(.ryzePreviewTitle)
            RyzeText(.ryzePreviewTitle)
            RyzeText(.ryzePreviewTitle)
            RyzeText(.ryzePreviewTitle)
        }
    }
}
