//
//  RyzeAccessibility.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/07/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public protocol RyzeAccessibility: RyzeResourceString {
    var hint: RyzeResourceString { get }
    var label: RyzeResourceString { get }
    var identifier: RyzeResourceString { get }
}
