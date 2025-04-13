//
//  RefdsNetworkAdapter.swift
//  Refds
//
//  Created by Rafael Escaleira on 02/04/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

public actor RefdsNetworkAdapter: RefdsNetworkClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Request: RefdsNetworkRequest, Response: RefdsEntity>(
        on request: Request,
        with dateStyle: DateFormatter.Style?,
        for type: Response.Type
    ) async throws -> Response {
        guard let endpoint = await request.endpoint else { throw RefdsNetworkError.invalidURL }
        let urlRequest = try await endpoint.request
        
        do {
            return try await retrieveCache(
                on: endpoint,
                with: dateStyle,
                for: type
            )
        } catch {
            let result = try await session.data(for: urlRequest)
            try await storeCache(on: endpoint, with: result)
            return try await request.decode(
                data: result.0,
                with: dateStyle,
                for: type
            )
        }
    }
    
    private func retrieveCache<Response: RefdsEntity>(
        on endpoint: RefdsNetworkEndpoint,
        with dateStyle: DateFormatter.Style?,
        for type: Response.Type
    ) async throws -> Response {
        let urlRequest = try await endpoint.request
        
        guard let cacheResponse = URLCache.shared.cachedResponse(for: urlRequest),
              let cacheInterval = cacheResponse.value(forKey: .cacheIntervalKey) as? Date,
              cacheInterval > .now
        else {
            throw RefdsNetworkError.noCache
        }
        
        return try cacheResponse.data.entity(
            for: type,
            with: dateStyle
        )
    }
    
    private func storeCache(
        on endpoint: RefdsNetworkEndpoint,
        with result: (Data, URLResponse),
    ) async throws {
        guard let cacheInterval = endpoint.cacheInterval else { return }
        let cacheResponse = CachedURLResponse(response: result.1, data: result.0)
        cacheResponse.setValue(cacheInterval, forKey: .cacheIntervalKey)
        let urlRequest = try await endpoint.request
        URLCache.shared.storeCachedResponse(cacheResponse, for: urlRequest)
    }
}
