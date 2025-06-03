//
//  BinaryFloatingPoint+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/06/25.
//

@_exported import Foundation

public extension BinaryFloatingPoint {
    var abs: Self {
        Swift.abs(self)
    }

    var double: Double {
        Double(self)
    }

    var int: Int {
        Int(self)
    }
    
    var string: String {
        String(double)
    }

    func formatted(decimals: Int = 2, locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = decimals
        formatter.maximumFractionDigits = decimals
        formatter.locale = locale
        return formatter.string(from: NSNumber(value: double))
    }

    func currency(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter.string(from: NSNumber(value: double))
    }
}
