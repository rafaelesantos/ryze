//
//  RyzeResourceString.swift
//  Ryze
//
//  Created by Rafael Escaleira on 28/03/25.
//

public protocol RyzeResourceString {
    var localized: LocalizedStringKey { get }
    var value: String { get }
}
