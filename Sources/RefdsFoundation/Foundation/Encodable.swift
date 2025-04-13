//
//  RefdsEncodable.swift
//  Refds
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

public extension Encodable {
    var json: String {
        get throws {
            return try data().string
        }
    }
    
    func data(with dateStyle: DateFormatter.Style = .long) throws -> Data {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateStyle = dateStyle
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return try encoder.encode(self)
    }
}
