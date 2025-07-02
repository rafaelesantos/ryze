//
//  RyzeFontProtocol.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

@_exported import SwiftUI

public protocol RyzeFontProtocol {
    var largeTitle: Font { get }
    var title: Font { get }
    var title2: Font { get }
    var title3: Font { get }
    var headline: Font { get }
    var subheadline: Font { get }
    var body: Font { get }
    var callout: Font { get }
    var footnote: Font { get }
    var caption: Font { get }
}
