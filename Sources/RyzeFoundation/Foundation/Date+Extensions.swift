//
//  Date+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 03/06/25.
//

@_exported import Foundation

public extension Date {
    var timestamp: Int {
        Int(self.timeIntervalSince1970)
    }

    var milliseconds: Int {
        Int(self.timeIntervalSince1970 * 1000)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    func string(with format: String.DateFormat) -> String {
        format.formatter.string(from: self)
    }
}
