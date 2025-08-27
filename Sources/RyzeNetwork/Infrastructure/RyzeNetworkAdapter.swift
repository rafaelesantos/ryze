//
//  RyzeNetworkAdapter.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/04/25.
//

import Foundation
import RyzeFoundation

public actor RyzeNetworkAdapter: RyzeNetworkClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Request>(
        on request: Request,
        with formatter: DateFormatter?
    ) async throws -> Request.Response where Request : RyzeNetworkRequest {
        let endpoint = await request.endpoint
        let urlRequest = try endpoint.request
        let logger = RyzeNetworkLogger()
        logger.info("🚀 Request started: \(urlRequest.url?.absoluteString ?? "nil")")

        do {
            let response = try await retrieveCache(on: request, with: formatter)
            logger.info("✅ Cache hit for: \(urlRequest.url?.absoluteString ?? "nil")")
            return response
        } catch {
            logger.warning("❌ Cache miss for: \(urlRequest.url?.absoluteString ?? "nil") - \(error.localizedDescription)")
            let (data, response) = try await session.data(for: urlRequest)
            try await storeCache(on: endpoint, data: data, response: response)
            return try await request.decode(data: data, with: formatter)
        }
    }
    
    private func retrieveCache<Request: RyzeNetworkRequest>(
        on request: Request,
        with formatter: DateFormatter?
    ) async throws -> Request.Response {
        let urlRequest = try await request.endpoint.request
        let logger = RyzeNetworkLogger()
        
        guard await request.endpoint.cacheInterval != nil,
              let url = urlRequest.url?.absoluteString,
              let cacheResponse = URLCache.shared.cachedResponse(for: urlRequest),
              let cacheInterval = cacheResponse.userInfo?[url] as? TimeInterval,
              cacheInterval > Date.now.timeIntervalSince1970
        else {
            logger.info("📭 No cache for: \(urlRequest.url?.absoluteString ?? "nil")")
            throw RyzeNetworkError.noCache
        }

        logger.info("⏳ Cache valid for: \(urlRequest.url?.absoluteString ?? "nil") until \(Date(timeIntervalSince1970: cacheInterval))")
        
        return try cacheResponse.data.entity(for: Request.Response.self, with: formatter)
    }
    
    private func storeCache(
        on endpoint: RyzeNetworkEndpoint,
        data: Data,
        response: URLResponse
    ) async throws {
        let logger = RyzeNetworkLogger()
        guard let cacheInterval = endpoint.cacheInterval,
              let url = endpoint.url?.absoluteString
        else {
            let url = endpoint.url?.absoluteString
            logger.info("⏱️ No cache interval set for: \(url ?? "nil")")
            return
        }

        let userInfo: [String: TimeInterval] = [url: Date.now.timeIntervalSince1970 + cacheInterval]
        let cacheResponse = CachedURLResponse(
            response: response,
            data: data,
            userInfo: userInfo,
            storagePolicy: .allowed
        )

        let urlRequest = try endpoint.request
        URLCache.shared.storeCachedResponse(cacheResponse, for: urlRequest)
        logger.info("💾 Cache stored for: \(urlRequest.url?.absoluteString ?? "nil") until \(Date(timeIntervalSince1970: cacheInterval))")
    }
}
