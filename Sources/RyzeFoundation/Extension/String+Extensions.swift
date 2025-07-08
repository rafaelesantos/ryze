//
//  String+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 15/05/25.
//

public extension String {
    var breakLine: String {
        self + "\n"
    }
    
    var space: String {
        self + " "
    }
    
    var double: Double? {
        Double(self)
    }
    
    var int: Int? {
        Int(self)
    }
    
    func date(with format: DateFormat) -> Date? {
        format.date(from: self)
    }
}

public extension String {
    enum DateFormat: String {
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yearMonthDay = "yyyy-MM-dd"
        case dayMonthYearSlash = "dd/MM/yyyy"
        case monthDayYearSlash = "MM/dd/yyyy"
        case dayMonthYearDash = "dd-MM-yyyy"
        case compact = "yyyyMMdd"
        case monthDayYearText = "MMM dd, yyyy"
        case dayMonthYearText = "dd MMM yyyy"
        case iso8601WithMilliseconds = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case time24h = "HH:mm"
        case time12h = "hh:mm a"
        case fullDateTime = "EEEE, MMM d, yyyy h:mm a"
        case shortDateTime = "M/d/yy, h:mm a"
        case dateTimeWithSlashes = "dd/MM/yyyy HH:mm"
        case dateTimeWithDashes = "dd-MM-yyyy HH:mm"
        case rfc1123 = "EEE',' dd MMM yyyy HH':'mm':'ss zzz"
        
        public var formatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = self.rawValue
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone.current
            return formatter
        }
        
        public func string(from date: Date) -> String {
            formatter.string(from: date)
        }
        
        public func date(from string: String) -> Date? {
            formatter.date(from: string)
        }
    }
}
