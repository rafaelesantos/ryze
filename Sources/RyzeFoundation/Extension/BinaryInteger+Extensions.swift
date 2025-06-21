//
//  BinaryInteger+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/06/25.
//

@_exported import Foundation

public extension BinaryInteger {
    var isEven: Bool {
        self % 2 == 0
    }

    var isOdd: Bool {
        !isEven
    }

    var double: Double {
        Double(self)
    }
    
    var string: String {
        String(self)
    }

    var timestamp: Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }

    var milliseconds: Date {
        Date(timeIntervalSince1970: TimeInterval(self) / 1000)
    }

    func formatted(withSeparator: Bool = true) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.usesGroupingSeparator = withSeparator
        let number = NSNumber(value: Int64(self))
        return formatter.string(from: number)
    }

    func currency(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        let number = NSNumber(value: Int64(self))
        return formatter.string(from: number)
    }
}
