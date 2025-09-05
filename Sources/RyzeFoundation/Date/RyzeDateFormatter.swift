//
//  RyzeDateFormatter.swift
//  Ryze
//
//  Created by Rafael Escaleira on 29/08/25.
//

@_exported import Foundation

public protocol RyzeDateFormatter {
    var rawValue: DateFormatter { get }
    
    func string(from date: Date?) -> String?
    func date(from string: String?) -> Date?
}

public extension RyzeDateFormatter {
    func getFormatter(from format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = RyzeLocale.current.rawValue
        return formatter
    }
    
    func string(from date: Date?) -> String? {
        guard let date else { return nil }
        return rawValue.string(from: date)
    }
    
    func date(from string: String?) -> Date? {
        guard let string else { return nil }
        return rawValue.date(from: string)
    }
}
