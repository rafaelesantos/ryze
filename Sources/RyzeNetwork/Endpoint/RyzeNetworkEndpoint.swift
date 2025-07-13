//
//  RyzeNetworkEndpoint.swift
//  Ryze
//
//  Created by Rafael Escaleira on 28/03/25.
//

@_exported import Foundation
@_exported import RyzeFoundation

public protocol RyzeNetworkEndpoint: RyzeLogger, Sendable {
    var scheme: RyzeNetworkScheme { get }
    var host: String { get }
    var path: String { get }
    var method: RyzeNetworkMethod { get }
    var queryItems: RyzeNetworkQuery { get }
    var headers: RyzeNetworkHeader { get }
    var body: Encodable? { get }
    var cacheInterval: Date? { get }
}

public extension RyzeNetworkEndpoint {
    var scheme: RyzeNetworkScheme { .https }
    var method: RyzeNetworkMethod { .get }
    var queryItems: RyzeNetworkQuery { .empty() }
    var headers: RyzeNetworkHeader { .empty() }
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
                let error = RyzeNetworkError.invalidURL
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
    
    var logger: Logger {
        Logger(
            subsystem: Bundle.module.bundleIdentifier ?? String(describing: self),
            category: String(describing: self)
        )
    }
    
    func log() {
        Task(priority: .low) {
            if let url = await url {
                logger.info("🌐 URL: \(url.absoluteString)")
            }
            
            if await !headers.get().isEmpty {
                let headers = await headers.get()
                logger.info("📋 Headers: \(headers)")
            }
            
            if let body = try? body?.json {
                logger.info("📝 Body: \(body)")
            }
        }
    }
}
