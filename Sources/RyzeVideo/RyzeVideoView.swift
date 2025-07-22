//
//  RyzeVideoView.swift
//  Ryze
//
//  Created by Rafael Escaleira on 22/07/25.
//

@_exported import SwiftUI
@_exported import AVKit

public struct RyzeVideoView: View {
    @State private var player: AVPlayer?
    @Binding private var url: URL?
    
    public init(url: Binding<URL?>) {
        self._url = url
    }
    
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                if let player {
                    RyzeVideoPlayer(player: player)
                        .frame(width: proxy.size.width, height: proxy.size.width * (9 / 16))
                }
            }
        }
        .onChange(of: url) {
            guard let url else {
                return player = nil
            }
            player = AVPlayer(url: url)
        }
        .onDisappear {
            player?.pause()
        }
    }
}
