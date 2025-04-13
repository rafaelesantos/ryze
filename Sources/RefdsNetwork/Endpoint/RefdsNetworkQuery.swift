//
//  RefdsNetworkQuery.swift
//  Refds
//
//  Created by Rafael Escaleira on 29/03/25.
//

public actor RefdsNetworkQuery {
    private var queryItems: [URLQueryItem] = []
    
    public static func empty() -> RefdsNetworkQuery {
        makeQuery()
    }
    
    public static func makeQuery() -> RefdsNetworkQuery {
        RefdsNetworkQuery()
    }
    
    public func addQuery(for key: String, with value: Any) -> RefdsNetworkQuery {
        queryItems.append(.init(name: key, value: "\(value)"))
        return self
    }
    
    func get() -> [URLQueryItem] {
        queryItems
    }
}
