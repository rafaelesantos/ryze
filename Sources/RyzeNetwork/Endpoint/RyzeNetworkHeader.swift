//
//  RyzeNetworkHeader.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/03/25.
//

public actor RyzeNetworkHeader: Sendable {
    private var headers: [String: String] = [:]
    
    public static func makeHeader() -> RyzeNetworkHeader {
        RyzeNetworkHeader()
    }
    
    public static func empty() -> RyzeNetworkHeader {
        makeHeader()
    }
    
    public func accept(for type: RyzeNetworkHeaderType) -> RyzeNetworkHeader {
        headers["Accept"] = type.rawValue
        return self
    }
    
    public func contentType(for type: RyzeNetworkHeaderType) -> RyzeNetworkHeader {
        headers["Content-Type"] = type.rawValue
        return self
    }
    
    public func authorization(for token: String) -> RyzeNetworkHeader {
        headers["Authorization"] = token
        return self
    }
    
    public func cache(for interval: Date) -> RyzeNetworkHeader {
        headers["Cache-Control"] = "max-age=\(interval.timeIntervalSince1970)"
        return self
    }
    
    public func custom(header: String, value: String) -> RyzeNetworkHeader {
        headers[header] = value
        return self
    }
    
    public func get() -> [String: String] {
        headers
    }
}
