//
//  URL+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 22/07/25.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: String {
        self.absoluteString
    }
}
