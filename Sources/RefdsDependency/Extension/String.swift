//
//  String.swift
//  Refds
//
//  Created by Rafael Escaleira on 28/03/25.
//

import Foundation

extension String {
    static func localized(for key: RefdsDendencyString) -> Self {
        key.localized()
    }
    
    static func localized(
        for key: RefdsDendencyString,
        with arguments: CVarArg...
    ) -> Self {
        String(
            format: key.localized(),
            arguments: arguments
        )
    }
}
