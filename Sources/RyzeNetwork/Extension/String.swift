//
//  String.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/04/25.
//

import Foundation

extension String {
    static func localized(for key: RyzeNetworkString) -> Self {
        key.localized()
    }
    
    static func localized(
        for key: RyzeNetworkString,
        with arguments: CVarArg...
    ) -> Self {
        String(
            format: key.localized(),
            arguments: arguments
        )
    }
    
    static var cacheIntervalKey: Self {
        .localized(for: .cacheInvertvalKey)
    }
}
