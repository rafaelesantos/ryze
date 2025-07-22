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
        playerView
            .onChange(of: url) { updatePlayer() }
    }
    
    @ViewBuilder
    var playerView: some View {
        if let player {
            RyzeVideoPlayer(player: player)
        }
    }
    
    func updatePlayer() {
        guard let url else { return player = nil }
        player = AVPlayer(url: url)
    }
}
