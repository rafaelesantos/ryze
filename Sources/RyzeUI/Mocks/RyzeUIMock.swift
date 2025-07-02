//
//  RyzeUIMock.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/06/25.
//

@_exported import SwiftUI

@MainActor
public protocol RyzeUIMock {
    associatedtype MockView: View
    static var mock: MockView { get }
}
