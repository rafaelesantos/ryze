//
//  Data+Extensions.swift
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
        with formatter: DateFormatter? = nil
    ) throws -> T {
        let jsonDecoder = JSONDecoder()
        guard let formatter else { return try jsonDecoder.decode(T.self, from: self) }
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        return try jsonDecoder.decode(T.self, from: self)
    }
}
