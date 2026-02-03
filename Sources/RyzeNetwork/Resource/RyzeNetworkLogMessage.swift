//
//  RyzeNetworkLogMessage.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/07/25.
//

import RyzeFoundation

enum RyzeNetworkLogMessage: RyzeResourceLogMessage {
    case url(URL)
    case headers([String: String])
    case body(String)
    case host(String)
    case port(UInt16)
    case parameters(String)
    case requestStart(String?)
    case cacheHit(String?)
    case cacheMiss(String?, String)
    case responseCached(String?)
    case noCache(String?)
    case cacheWithExpiration(String?, TimeInterval)
    case noCacheInterval(String?)
    case cacheStored(String?, TimeInterval)
    case invalidURL(String)
    case connecting(String, String, String)
    case connectionEstablished(String, String)
    case connectionClosed(String, String)
    case disconnected(String, String)
    case connectionReady
    case connectionCancelled
    case connectionFailed(String)
    case connectionStateChanged(String?)
    case receiveError(String)
    case receptionComplete
    case failedToEncode(String)
    case sendingMessage(String)
    case messageSent(String)
    case sendError(String)

    var key: String {
        switch self {
        case .url: return "log.url"
        case .headers: return "log.headers"
        case .body: return "log.body"
        case .host: return "log.host"
        case .port: return "log.port"
        case .parameters: return "log.parameters"
        case .requestStart: return "log.requestStart"
        case .cacheHit: return "log.cacheHit"
        case .cacheMiss: return "log.cacheMiss"
        case .responseCached: return "log.responseCached"
        case .noCache: return "log.noCache"
        case .cacheWithExpiration: return "log.cacheWithExpiration"
        case .noCacheInterval: return "log.noCacheInterval"
        case .cacheStored: return "log.cacheStored"
        case .invalidURL: return "log.invalidURL"
        case .connecting: return "log.connecting"
        case .connectionEstablished: return "log.connectionEstablished"
        case .connectionClosed: return "log.connectionClosed"
        case .disconnected: return "log.disconnected"
        case .connectionReady: return "log.connectionReady"
        case .connectionCancelled: return "log.connectionCancelled"
        case .connectionFailed: return "log.connectionFailed"
        case .connectionStateChanged: return "log.connectionStateChanged"
        case .receiveError: return "log.receiveError"
        case .receptionComplete: return "log.receptionComplete"
        case .failedToEncode: return "log.failedToEncode"
        case .sendingMessage: return "log.sendingMessage"
        case .messageSent: return "log.messageSent"
        case .sendError: return "log.sendError"
        }
    }
    
    var format: String {
        String(
            localized: .init(key),
            table: "RyzeNetworkLogMessage",
            bundle: Bundle(),
            locale: RyzeLocale.current.rawValue
        )
    }
    
    func formatted(with arguments: CVarArg...) -> String {
        String(format: format, arguments)
    }
    
    var value: String {
        switch self {
        case let .url(url): return formatted(with: url.absoluteString)
        case let .headers(headers): return formatted(with: headers.description)
        case let .body(body): return formatted(with: body)
        case let .host(host): return formatted(with: host)
        case let .port(port): return formatted(with: "\(port)")
        case let .parameters(params): return formatted(with: params)
        case let .requestStart(url): return formatted(with: url ?? "")
        case let .cacheHit(key): return formatted(with: key ?? "")
        case let .cacheMiss(key, error): return formatted(with: key ?? "", error)
        case let .responseCached(url): return formatted(with: url ?? "")
        case let .noCache(url): return formatted(with: url ?? "")
        case let .cacheWithExpiration(url, expiration): return formatted(with: url ?? "", expiration.description)
        case let .noCacheInterval(url): return formatted(with: url ?? "")
        case let .cacheStored(url, interval): return formatted(with: url ?? "", interval)
        case let .invalidURL(url): return formatted(with: url)
        case let .connecting(host, port, params): return formatted(with: host, port, params)
        case let .connectionEstablished(host, port): return formatted(with: host, port)
        case let .connectionClosed(host, port): return formatted(with: host, port)
        case let .disconnected(host, port): return formatted(with: host, port)
        case .connectionReady: return format
        case .connectionCancelled: return format
        case let .connectionFailed(error): return formatted(with: error)
        case let .connectionStateChanged(state): return formatted(with: state ?? "")
        case let .receiveError(error): return formatted(with: error)
        case .receptionComplete: return format
        case let .failedToEncode(message): return formatted(with: message)
        case let .sendingMessage(message): return formatted(with: message)
        case let .messageSent(message): return formatted(with: message)
        case let .sendError(error): return formatted(with: error)
        }
    }
}
