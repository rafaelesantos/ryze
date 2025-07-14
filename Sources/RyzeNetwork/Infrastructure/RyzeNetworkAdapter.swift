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
        logger.info(.requestStart(urlRequest.url?.absoluteString))

        do {
            let response = try await retrieveCache(on: request, with: formatter)
            logger.info(.cacheHit(urlRequest.url?.absoluteString))
            return response
        } catch {
            logger.warning(.cacheMiss(urlRequest.url?.absoluteString, error.localizedDescription))
            let (data, response) = try await session.data(for: urlRequest)
            
            try await storeCache(on: endpoint, data: data, response: response)
            logger.info(.responseCached(urlRequest.url?.absoluteString))
            
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
              let cacheInterval = cacheResponse.userInfo?[url] as? Date,
              cacheInterval > .now
        else {
            logger.info(.noCache(urlRequest.url?.absoluteString))
            throw RyzeNetworkError.noCache
        }

        logger.info(.cacheWithExpiration(urlRequest.url?.absoluteString, cacheInterval))
        
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
            logger.info(.noCacheInterval(url))
            return
        }

        let userInfo: [String: TimeInterval] = [url: cacheInterval]
        let cacheResponse = CachedURLResponse(
            response: response,
            data: data,
            userInfo: userInfo,
            storagePolicy: .allowed
        )

        let urlRequest = try endpoint.request
        URLCache.shared.storeCachedResponse(cacheResponse, for: urlRequest)
        logger.info(.cacheStored(urlRequest.url?.absoluteString, cacheInterval))
    }
}
