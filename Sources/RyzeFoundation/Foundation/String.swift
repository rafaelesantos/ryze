//
//  String.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

public extension String {
    var breakLine: String {
        self + "\n"
    }
    
    var double: Double? {
        Double(self)
    }
    
    var int: Int? {
        Int(self)
    }
}
