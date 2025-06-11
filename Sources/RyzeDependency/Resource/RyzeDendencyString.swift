//
//  RyzeDendencyString.swift
//  Ryze
//
//  Created by Rafael Escaleira on 28/03/25.
//

@_exported import Foundation
@_exported import RyzeFoundation

enum RyzeDendencyString: String, RyzeResourceString {
    case unregisteredDependencyDescription
    case unregisteredDependencyErrorDescription
    case unregisteredDependencyFailureReason
    case unregisteredDependencyRecoverySuggestion
    
    var localized: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
    
    var value: String {
        String(
            localized: .init(rawValue),
            bundle: .module,
            locale: RyzeLocale.current.rawValue
        )
    }
}
