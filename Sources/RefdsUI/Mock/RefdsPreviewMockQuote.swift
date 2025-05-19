//
//  RefdsPreviewMockQuote.swift
//  Refds
//
//  Created by Rafael Escaleira on 25/04/25.
//

public enum RefdsPreviewMockQuote: CaseIterable, Equatable {
    case forceUnwrap
    case mergeConflict
    case rubberDuck
    case legacyCode
    case infiniteLoop
    case spaghettiCode
    case coffeeDriven
    case fridayDeploy
    case stackOverflowCopy
    case debugPrint
    
    var title: RefdsUIString {
        switch self {
        case .forceUnwrap: return .forceUnwrapTitle
        case .mergeConflict: return .mergeConflictTitle
        case .rubberDuck: return .rubberDuckTitle
        case .legacyCode: return .legacyCodeTitle
        case .infiniteLoop: return .infiniteLoopTitle
        case .spaghettiCode: return .spaghettiCodeTitle
        case .coffeeDriven: return .coffeeDrivenTitle
        case .fridayDeploy: return .fridayDeployTitle
        case .stackOverflowCopy: return .stackOverflowCopyTitle
        case .debugPrint: return .debugPrintTitle
        }
    }
    
    var description: RefdsUIString {
        switch self {
        case .forceUnwrap: return .forceUnwrapDescription
        case .mergeConflict: return .mergeConflictDescription
        case .rubberDuck: return .rubberDuckDescription
        case .legacyCode: return .legacyCodeDescription
        case .infiniteLoop: return .infiniteLoopDescription
        case .spaghettiCode: return .spaghettiCodeDescription
        case .coffeeDriven: return .coffeeDrivenDescription
        case .fridayDeploy: return .fridayDeployDescription
        case .stackOverflowCopy: return .stackOverflowCopyDescription
        case .debugPrint: return .debugPrintDescription
        }
    }
    
    var emoji: String {
        switch self {
        case .forceUnwrap: return "💥"
        case .mergeConflict: return "⚔️"
        case .rubberDuck: return "🦆"
        case .legacyCode: return "🧟‍♂️"
        case .infiniteLoop: return "♾️"
        case .spaghettiCode: return "🍝"
        case .coffeeDriven: return "☕️"
        case .fridayDeploy: return "🔥"
        case .stackOverflowCopy: return "📋"
        case .debugPrint: return "🐞"
        }
    }
}
