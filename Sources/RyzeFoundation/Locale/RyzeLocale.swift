//
//  Locale.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

@_exported import Foundation
@_exported import SwiftUI

public enum RyzeLocale: CaseIterable, Sendable {
    case englishUS
    case portugueseBR
    case spanishES
    case frenchFR
    case germanDE
    case arabicSA
    case japaneseJP
    case chineseCN
    
    public var rawValue: Locale {
        Locale(identifier: identifier)
    }
    
    public var emoji: String {
        switch self {
        case .englishUS: return "🇺🇸"
        case .portugueseBR: return "🇧🇷"
        case .spanishES: return "🇪🇸"
        case .frenchFR: return "🇫🇷"
        case .germanDE: return "🇩🇪"
        case .arabicSA: return "🇸🇦"
        case .japaneseJP: return "🇯🇵"
        case .chineseCN: return "🇨🇳"
        }
    }
    
    public var description: String {
        switch self {
        case .englishUS: return "\(emoji) English (US)"
        case .portugueseBR: return "\(emoji) Português (BR)"
        case .spanishES: return "\(emoji) Español"
        case .frenchFR: return "\(emoji) Français"
        case .germanDE: return "\(emoji) Deutsch"
        case .arabicSA: return "\(emoji) العربية"
        case .japaneseJP: return "\(emoji) 日本語"
        case .chineseCN: return "\(emoji) 中文"
        }
    }
    
    public var languageCode: String? {
        rawValue.language.languageCode?.identifier
    }
    
    public var identifier: String {
        switch self {
        case .englishUS: return "en_US"
        case .portugueseBR: return "pt_BR"
        case .spanishES: return "es_ES"
        case .frenchFR: return "fr_FR"
        case .germanDE: return "de_DE"
        case .arabicSA: return "ar_SA"
        case .japaneseJP: return "ja_JP"
        case .chineseCN: return "zh_CN"
        }
    }
    
    var isRTL: Bool {
        ["ar", "he", "fa", "ur"].contains(languageCode)
    }
    
    public var currencyCode: String {
        rawValue.currency?.identifier ?? "USD"
    }
    
    public var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        
        switch self {
        case .japaneseJP:
            calendar = Calendar(identifier: .japanese)
        case .arabicSA:
            calendar = Calendar(identifier: .islamicUmmAlQura)
        default:
            break
        }
        
        calendar.locale = rawValue
        return calendar
    }
    
    public var dateFormatStyle: Date.FormatStyle {
        var style = Date.FormatStyle()
        style.locale = rawValue
        style.calendar = calendar
        return style
    }
    
    public static var current: RyzeLocale {
        let languageCode = Locale.current.language.languageCode?.identifier
        return RyzeLocale.allCases.first(where: { $0.languageCode == languageCode }) ?? .englishUS
    }
}
