//
//  RyzeTextFieldConfiguration.swift
//  Ryze
//
//  Created by Rafael Escaleira on 12/06/25.
//

@_exported import SwiftUI
@_exported import RyzeFoundation

public protocol RyzeTextFieldConfiguration {
    var placeholder: RyzeResourceString { get }
    var mask: RyzeTextFieldMask? { get }
    var icon: String? { get }
    var contentType: RyzeTextFieldContentType { get }
    var autocapitalizationType: RyzeTextInputAutocapitalization { get }
    var submitLabel: SubmitLabel { get }
    
    func validate(text: String) throws
}
