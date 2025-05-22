//
//  String.swift
//  Ryze
//
//  Created by Rafael Escaleira on 28/03/25.
//

import Foundation

extension String {
    static func localized(for key: RyzeDendencyString) -> Self {
        key.localized()
    }
    
    static func localized(
        for key: RyzeDendencyString,
        with arguments: CVarArg...
    ) -> Self {
        String(
            format: key.localized(),
            arguments: arguments
        )
    }
}
