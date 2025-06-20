//
//  String+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 28/03/25.
//

import Foundation

extension String {
    static func localized(for key: RyzeDendencyString) -> Self {
        key.value
    }
    
    static func localized(
        for key: RyzeDendencyString,
        with arguments: CVarArg...
    ) -> Self {
        String(
            format: key.value,
            arguments: arguments
        )
    }
}
