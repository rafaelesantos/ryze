//
//  String+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

import Foundation

public extension String {
    var breakLine: String {
        self + "\n"
    }
    
    static var breakLine: String {
        "\n"
    }
    
    var space: String {
        self + " "
    }
    
    static var space: String {
        " "
    }
    
    var double: Double? {
        Double(self)
    }
    
    var int: Int? {
        Int(self)
    }
    
    func date(with formatter: RyzeDateFormatter) -> Date? {
        formatter.date(from: self)
    }
}
