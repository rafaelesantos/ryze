//
//  RefdsUIString.swift
//  Refds
//
//  Created by Rafael Escaleira on 25/04/25.
//

@_exported import Foundation
@_exported import RefdsFoundation

enum RefdsUIString: String, RefdsResourceString, CaseIterable {
    case forceUnwrapTitle
    case forceUnwrapDescription
    case mergeConflictTitle
    case mergeConflictDescription
    case rubberDuckTitle
    case rubberDuckDescription
    case legacyCodeTitle
    case legacyCodeDescription
    case infiniteLoopTitle
    case infiniteLoopDescription
    case spaghettiCodeTitle
    case spaghettiCodeDescription
    case coffeeDrivenTitle
    case coffeeDrivenDescription
    case fridayDeployTitle
    case fridayDeployDescription
    case stackOverflowCopyTitle
    case stackOverflowCopyDescription
    case debugPrintTitle
    case debugPrintDescription
    
    func localized() -> String {
        String(
            localized: .init(stringLiteral: self.rawValue),
            bundle: .module
        )
    }
}
