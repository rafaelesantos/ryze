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
}
