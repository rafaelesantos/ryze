//
//  String.swift
//  Refds
//
//  Created by Rafael Escaleira on 25/04/25.
//

public extension String {
    static var refdsPreviewTitle: String {
        let cases = RefdsPreviewMockQuote.allCases
        let index = Int.random(in: 0 ..< cases.count)
        return cases[index].title.localized()
    }
    
    static var refdsPreviewDescription: String {
        let cases = RefdsPreviewMockQuote.allCases
        let index = Int.random(in: 0 ..< cases.count)
        return cases[index].description.localized()
    }
    
    static var refdsPreviewEmoji: String {
        let cases = RefdsPreviewMockQuote.allCases
        let index = Int.random(in: 0 ..< cases.count)
        return cases[index].emoji
    }
}
