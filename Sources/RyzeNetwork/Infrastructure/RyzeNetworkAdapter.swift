//
//  RyzeNetworkAdapter.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/04/25.
//

import Foundation
import RyzeFoundation

actor RyzeNetworkAdapter: RyzeNetworkClient {
    typealias Resolved = RyzeNetworkAdapter
    private let session: URLSession
    
    nonisolated private var logger: Logger {
        Logger(
            subsystem: Bundle.module.bundleIdentifier ?? String(describing: self),
            category: String(describing: self)
        )
    }
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<Request: RyzeNetworkRequest, Response: RyzeEntity>(
        on request: Request,
        with dateStyle: DateFormatter.Style?,
        for type: Response.Type
    ) async throws -> Response {
        guard let endpoint = await request.endpoint else {
            logger.error("❌ Invalid URL for request: \(String(describing: request))")
            throw RyzeNetworkError.invalidURL
        }
        let urlRequest = try await endpoint.request
        logger.info("🚀 Starting request to \(urlRequest.url?.absoluteString ?? "unknown URL")")
        
        do {
            let response = try await retrieveCache(on: endpoint, with: dateStyle, for: type)
            logger.info("📦 Cache hit for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            return response
        } catch {
            logger.warning("🗄️ Cache miss or error for \(urlRequest.url?.absoluteString ?? "unknown URL"): \(error.localizedDescription)")
            let (data, response) = try await session.data(for: urlRequest)
            
            try await storeCache(on: endpoint, with: (data, response))
            logger.info("✅ Response received and cached for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            
            return try await request.decode(data: data, with: dateStyle, for: type)
        }
    }
    
    private func retrieveCache<Response: RyzeEntity>(
        on endpoint: RyzeNetworkEndpoint,
        with dateStyle: DateFormatter.Style?,
        for type: Response.Type
    ) async throws -> Response {
        let urlRequest = try await endpoint.request
        
        guard let cacheResponse = URLCache.shared.cachedResponse(for: urlRequest),
              let cacheInterval = cacheResponse.value(forKey: .cacheIntervalKey) as? Date,
              cacheInterval > .now
        else {
            logger.info("🗑️ No valid cache found for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            throw RyzeNetworkError.noCache
        }
        
        logger.info("📦 Cache hit for \(urlRequest.url?.absoluteString ?? "unknown URL") with expiration at \(cacheInterval)")
        
        return try cacheResponse.data.entity(for: type, with: dateStyle)
    }
    
    private func storeCache(
        on endpoint: RyzeNetworkEndpoint,
        with result: (Data, URLResponse)
    ) async throws {
        guard let cacheInterval = endpoint.cacheInterval else {
            let url = await endpoint.url?.absoluteString
            logger.info("⏱️ No cache interval provided for \(url ?? "unknown URL"), skipping cache storage.")
            return
        }

        let cacheResponse = CachedURLResponse(response: result.1, data: result.0)
        cacheResponse.setValue(cacheInterval, forKey: .cacheIntervalKey)

        let urlRequest = try await endpoint.request
        URLCache.shared.storeCachedResponse(cacheResponse, for: urlRequest)
        logger.info("🗄️ Cached response stored for \(urlRequest.url?.absoluteString ?? "unknown URL") with interval \(cacheInterval)")
    }
}
