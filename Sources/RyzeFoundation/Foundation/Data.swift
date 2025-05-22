//
//  RyzeData.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

public extension Data {
    var string: String {
        String(
            data: self,
            encoding: .utf8
        ).unsafelyUnwrapped
    }
    
    func entity<T: Decodable>(
        for type: T.Type,
        with dateStyle: DateFormatter.Style? = nil
    ) throws -> T {
        let jsonDecoder = JSONDecoder()
        guard let dateStyle else { return try jsonDecoder.decode(T.self, from: self) }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try jsonDecoder.decode(T.self, from: self)
    }
}
