//
//  String.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

public extension String {
    static var ryzePreviewTitle: String {
        let cases = RyzePreviewMockQuote.allCases
        let index = Int.random(in: 0 ..< cases.count)
        return cases[index].title.localized()
    }
    
    static var ryzePreviewDescription: String {
        let cases = RyzePreviewMockQuote.allCases
        let index = Int.random(in: 0 ..< cases.count)
        return cases[index].description.localized()
    }
    
    static var ryzePreviewEmoji: String {
        let cases = RyzePreviewMockQuote.allCases
        let index = Int.random(in: 0 ..< cases.count)
        return cases[index].emoji
    }
}
