//
//  RyzeVideoPlayer.swift
//  Ryze
//
//  Created by Rafael Escaleira on 22/07/25.
//

import AVKit
import AVFoundation

#if canImport(AppKit)

struct RyzeVideoPlayer: NSViewRepresentable {
    let player: AVPlayer
    
    func updateNSView(_ NSView: NSView, context: NSViewRepresentableContext<RyzeVideoPlayer>) {
        guard let view = NSView as? AVPlayerView else { return }
        view.player = player
        view.allowsPictureInPicturePlayback = true
    }

    func makeNSView(context: Context) -> NSView {
        return AVPlayerView(frame: .zero)
    }
}

#elseif canImport(UIKit)

struct RyzeVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let vc = AVPlayerViewController()
        vc.player = player
        vc.canStartPictureInPictureAutomaticallyFromInline = true
        return vc
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}

#endif
