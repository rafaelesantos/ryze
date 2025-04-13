//
//  RefdsDendencyString.swift
//  Refds
//
//  Created by Rafael Escaleira on 28/03/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

enum RefdsDendencyString: String, RefdsResourceString {
    case unregisteredDependencyDescription
    case unregisteredDependencyErrorDescription
    case unregisteredDependencyFailureReason
    case unregisteredDependencyRecoverySuggestion
    
    func localized() -> String {
        String(
            localized: .init(stringLiteral: self.rawValue),
            bundle: .module
        )
    }
}
