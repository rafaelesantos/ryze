//
//  String+Extensions.swift
//  Ryze
//
//  Created by Rafael Escaleira on 25/04/25.
//

public extension String {
    static var ryzePreviewTitle: String {
        RyzeUIString.ryzePreviewTitle.value
    }
    
    static var ryzePreviewDescription: String {
        RyzeUIString.ryzePreviewDescription.value
    }
    
    static func ryzePreviewDisplayName<T>(
        _ type: T.Type,
        scheme: ColorScheme,
        locale: RyzeLocale
    ) -> String {
        let className = String(describing: type)
        let schemeName = scheme == .light ? "☀️ Light" : "🌒 Dark"
        let localeName = locale.description
        return "\(className) • \(schemeName) • \(localeName)"
    }
}
