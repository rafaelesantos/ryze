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
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
    var cacheInterval: TimeInterval? { get }
}

public extension RyzeNetworkEndpoint {
    var scheme: RyzeNetworkScheme { .https }
    var method: RyzeNetworkMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String: String] { [:] }
    var body: Encodable? { nil }
    var cacheInterval: TimeInterval? { nil }
    
    var url: URL? {
        urlComponents.url
    }
    
    private var urlComponents: URLComponents {
        var  urlComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    var request: URLRequest {
        get throws {
            log()
            guard let url = url else {
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
            urlRequest.allHTTPHeaderFields = headers
            
            if let body = (body as? String)?.data(using: .utf8) {
                urlRequest.httpBody = body
            } else if let body = try body?.data() {
                urlRequest.httpBody = body
            }
            
            return urlRequest
        }
    }
    
    func log() {
        let logger = RyzeNetworkLogger()
        if let url {
            logger.info("🔗 URL: \(url)")
        }

        if !headers.isEmpty {
            logger.info("📦 Headers: \(headers)")
        }

        if let body = try? body?.json {
            logger.info("✉️ Body: \(body)")
        }
    }
}

