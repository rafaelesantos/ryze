//
//  RyzeVideoDownloaderStatus.swift
//  Ryze
//
//  Created by Rafael Escaleira on 22/07/25.
//

@_exported import RyzeFoundation
@_exported import AVFoundation

public enum RyzeVideoDownloaderStatus: @unchecked Sendable {
    case downloading(
        progress: Double,
        session: AVAssetExportSession
    )
    case completed(path: URL)
    case error(RyzeVideoError)
}
