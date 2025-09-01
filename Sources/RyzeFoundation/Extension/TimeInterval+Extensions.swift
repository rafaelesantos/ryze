//
//  TimeInterval+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/07/25.
//

@_exported import Foundation

public extension TimeInterval {
    var seconds: TimeInterval {
        self
    }
    
    var minutes: TimeInterval {
        self / 60
    }
    
    var hours: TimeInterval {
        self / 3600
    }
    
    var days: TimeInterval {
        self / 86400
    }
    
    var date: Date {
        Date(timeIntervalSince1970: self)
    }
    
    var yearMonth: Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return (year * 100) + month
    }
}
