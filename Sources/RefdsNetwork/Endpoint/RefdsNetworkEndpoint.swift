//
//  RefdsNetworkEndpoint.swift
//  Refds
//
//  Created by Rafael Escaleira on 28/03/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

public protocol RefdsNetworkEndpoint: RefdsLogger, Sendable {
    var scheme: RefdsNetworkScheme { get }
    var host: String { get }
    var path: String { get }
    var method: RefdsNetworkMethod { get }
    var queryItems: RefdsNetworkQuery { get }
    var headers: RefdsNetworkHeader { get }
    var body: Encodable? { get }
    var cacheInterval: Date? { get }
}

public extension RefdsNetworkEndpoint {
    var scheme: RefdsNetworkScheme { .https }
    var method: RefdsNetworkMethod { .get }
    var queryItems: RefdsNetworkQuery { .empty() }
    var headers: RefdsNetworkHeader { .empty() }
    var body: Encodable? { nil }
    
    var url: URL? {
        get async {
            await urlComponents.url
        }
    }
    
    private var urlComponents: URLComponents {
        get async {
            var  urlComponents = URLComponents()
            urlComponents.scheme = scheme.rawValue
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = await queryItems.get()
            return urlComponents
        }
    }
    
    var request: URLRequest {
        get async throws {
            log()
            guard let url = await url else {
                let error = RefdsNetworkError.invalidURL
                error.log()
                throw error
            }
            
            let cachePolicy: URLRequest.CachePolicy = cacheInterval != nil ? .returnCacheDataElseLoad : .useProtocolCachePolicy
            
            var urlRequest = URLRequest(
                url: url,
                cachePolicy: cachePolicy
            )
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = await headers.get()
            guard let body = try body?.data() else { return urlRequest }
            urlRequest.httpBody = body
            return urlRequest
        }
    }
    
    func log() {
        Task(priority: .low) {
            if let url = await url {
                logger.info("\(url.absoluteString)")
            }
            
            if await !headers.get().isEmpty {
                let headers = await headers.get()
                logger.info("\(headers)")
            }
            
            if let body = try? body?.json {
                logger.info("\(body)")
            }
        }
    }
}
