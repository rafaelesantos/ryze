//
//  RefdsNetworkHeader.swift
//  Refds
//
//  Created by Rafael Escaleira on 29/03/25.
//

public actor RefdsNetworkHeader {
    private var headers: [String: String] = [:]
    
    public static func makeHeader() -> RefdsNetworkHeader {
        RefdsNetworkHeader()
    }
    
    public static func empty() -> RefdsNetworkHeader {
        makeHeader()
    }
    
    public func accept(for type: RefdsNetworkHeaderType) -> RefdsNetworkHeader {
        headers["Accept"] = type.rawValue
        return self
    }
    
    public func contentType(for type: RefdsNetworkHeaderType) -> RefdsNetworkHeader {
        headers["Content-Type"] = type.rawValue
        return self
    }
    
    public func authorization(for token: String) -> RefdsNetworkHeader {
        headers["Authorization"] = token
        return self
    }
    
    public func cache(for interval: Date) -> RefdsNetworkHeader {
        headers["Cache-Control"] = "max-age=\(interval.timeIntervalSince1970)"
        return self
    }
    
    public func custom(header: String, value: String) -> RefdsNetworkHeader {
        headers[header] = value
        return self
    }
    
    public func get() -> [String: String] {
        headers
    }
}
