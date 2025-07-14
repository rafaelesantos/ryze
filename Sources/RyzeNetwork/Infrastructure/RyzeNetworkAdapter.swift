//
//  RyzeNetworkAdapter.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/04/25.
//

import Foundation
import RyzeFoundation

public actor RyzeNetworkAdapter: RyzeNetworkClient {
    typealias Resolved = RyzeNetworkAdapter
    private let session: URLSession
    
    nonisolated private var logger: Logger {
        Logger(
            subsystem: Bundle.module.bundleIdentifier ?? String(describing: self),
            category: String(describing: self)
        )
    }
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    public func request<Request>(
        on request: Request,
        with formatter: DateFormatter?
    ) async throws -> Request.Response where Request : RyzeNetworkRequest {
        let endpoint = await request.endpoint
        let urlRequest = try endpoint.request
        logger.info("🚀 Starting request to \(urlRequest.url?.absoluteString ?? "unknown URL")")
        
        do {
            let response = try await retrieveCache(on: request, with: formatter)
            logger.info("📦 Cache hit for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            return response
        } catch {
            logger.warning("🗄️ Cache miss or error for \(urlRequest.url?.absoluteString ?? "unknown URL"): \(error.localizedDescription)")
            let (data, response) = try await session.data(for: urlRequest)
            
            try await storeCache(on: endpoint, with: (data, response))
            logger.info("✅ Response received and cached for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            
            return try await request.decode(data: data, with: formatter)
        }
    }
    
    private func retrieveCache<Request: RyzeNetworkRequest>(
        on request: Request,
        with formatter: DateFormatter?
    ) async throws -> Request.Response {
        let urlRequest = try await request.endpoint.request
        
        guard let cacheResponse = URLCache.shared.cachedResponse(for: urlRequest),
              let cacheInterval = cacheResponse.value(forKey: .cacheIntervalKey) as? Date,
              cacheInterval > .now
        else {
            logger.info("🗑️ No valid cache found for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            throw RyzeNetworkError.noCache
        }
        
        logger.info("📦 Cache hit for \(urlRequest.url?.absoluteString ?? "unknown URL") with expiration at \(cacheInterval)")
        
        return try cacheResponse.data.entity(for: Request.Response.self, with: formatter)
    }
    
    private func storeCache(
        on endpoint: RyzeNetworkEndpoint,
        with result: (Data, URLResponse)
    ) async throws {
        guard let cacheInterval = endpoint.cacheInterval else {
            let url = endpoint.url?.absoluteString
            logger.info("⏱️ No cache interval provided for \(url ?? "unknown URL"), skipping cache storage.")
            return
        }

        let cacheResponse = CachedURLResponse(response: result.1, data: result.0)
        cacheResponse.setValue(cacheInterval, forKey: .cacheIntervalKey)

        let urlRequest = try endpoint.request
        URLCache.shared.storeCachedResponse(cacheResponse, for: urlRequest)
        logger.info("🗄️ Cached response stored for \(urlRequest.url?.absoluteString ?? "unknown URL") with interval \(cacheInterval)")
    }
}
