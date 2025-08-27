//
//  Substring+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 27/08/25.
//

@_exported import Foundation

public extension Substring {
    var string: String {
        String(self)
    }
    
    var int: Int? {
        Int(self)
    }
    
    var double: Double? {
        Double(self)
    }
}
