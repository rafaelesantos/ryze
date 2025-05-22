//
//  RyzeNetworkQuery.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/03/25.
//

public actor RyzeNetworkQuery {
    private var queryItems: [URLQueryItem] = []
    
    public static func empty() -> RyzeNetworkQuery {
        makeQuery()
    }
    
    public static func makeQuery() -> RyzeNetworkQuery {
        RyzeNetworkQuery()
    }
    
    public func addQuery(for key: String, with value: Any) -> RyzeNetworkQuery {
        queryItems.append(.init(name: key, value: "\(value)"))
        return self
    }
    
    func get() -> [URLQueryItem] {
        queryItems
    }
}
