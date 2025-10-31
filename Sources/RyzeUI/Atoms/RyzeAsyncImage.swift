//
//  RyzeAsyncImage.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/07/25.
//

@_exported import SwiftUI

public struct RyzeAsyncImage: RyzeView {
    @Environment(\.theme) var theme
    let url: URL?
    let animated: Bool
    let content: ((Image) -> any View)?
    let placeholder: (() -> any View)?
    
    @State var image: Image?
    
    public init(
        _ source: String?,
        animated: Bool = false,
        content: ((Image) -> any View)? = nil,
        placeholder: (() -> any View)? = nil
    ) {
        self.url = URL(string: source ?? "")
        self.animated = animated
        self.content = content
        self.placeholder = placeholder
    }
    
    public init(
        _ url: URL?,
        animated: Bool = false,
        content: ((Image) -> any View)? = nil,
        placeholder: (() -> any View)? = nil
    ) {
        self.url = url
        self.animated = animated
        self.content = content
        self.placeholder = placeholder
    }
    
    public var body: some View {
        contentView
            .task { fetchImage() }
            .onChange(of: url) { fetchImage() }
            .ryze(if: animated) {
                $0.animation(theme.animation, value: image)
            }
    }
    
    private var contentView: some View {
        ZStack {
            if let image, let content {
                AnyView(content(image))
            } else if let image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Group {
                    if let placeholder {
                        AnyView(placeholder())
                    }
                }
            }
        }
    }
    
    var cacheInterval: TimeInterval {
        1.hour
    }
    
    func fetchImage() {
        Task { @MainActor in
            guard let url else { return }
            
            if let cachedImage = retrieveImage(for: url) {
                image = cachedImage
            } else if let cachedImage = await storeImage(for: url) {
                image = cachedImage
            }
        }
    }
    
    func retrieveImage(for url: URL) -> Image? {
        let request = URLRequest(url: url)
        if let cacheResponse = URLCache.shared.cachedResponse(for: request),
           let cacheInterval = cacheResponse.userInfo?[url.absoluteString] as? TimeInterval,
           cacheInterval > Date.now.timeIntervalSince1970 {
            #if canImport(UIKit)
            if let image = UIImage(data: cacheResponse.data) {
                return Image(uiImage: image)
            }
            #elseif canImport(AppKit)
            if let image = NSImage(data: cacheResponse.data) {
                return Image(nsImage: image)
            }
            #endif
        }
        return nil
    }
    
    func storeImage(for url: URL) async -> Image? {
        let request = URLRequest(url: url)
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return nil }
        let cachedData = CachedURLResponse(response: response, data: data, userInfo: [url.absoluteString: Date.now.timeIntervalSince1970 + cacheInterval], storagePolicy: .allowed)
        URLCache.shared.storeCachedResponse(cachedData, for: request)
        
        #if canImport(UIKit)
        if let image = UIImage(data: data) {
            return Image(uiImage: image)
        }
        #elseif canImport(AppKit)
        if let image = NSImage(data: data) {
            return Image(nsImage: image)
        }
        #endif
        return nil
    }
    
    public static var mock: some View {
        RyzeAsyncImage("https://picsum.photos/id/42/600")
    }
}

#Preview {
    RyzeAsyncImage.mock
}
