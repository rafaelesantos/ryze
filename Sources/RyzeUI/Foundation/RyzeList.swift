//
//  RyzeList.swift
//  Ryze
//
//  Created by Rafael Escaleira on 05/06/25.
//

@_exported import SwiftUI

public struct RyzeList<Content: View>: View {
    @Environment(\.ryzeTheme) private var theme
    
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        List { content }
    }
}

#Preview {
    RyzeList {
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
