//
//  RefdsDefaultColor.swift
//  Refds
//
//  Created by Rafael Escaleira on 19/04/25.
//

struct RefdsDefaultColor: RefdsColorProtocol {
    var primary: Color
    var secondary: Color
    var background: Color
    var shadow: Color
    var surface: Color
    var text: Color
    var textSecondary: Color
    var border: Color
    var error: Color
    var success: Color
    var warning: Color
    var info: Color
    var disabled: Color
    var hover: Color
    var pressed: Color
    
    init(
        primary: Color = Color(.primary),
        secondary: Color = Color(.secondary),
        background: Color = Color(.background),
        shadow: Color = Color(.shadow),
        surface: Color = Color(.surface),
        text: Color = Color(.text),
        textSecondary: Color = Color(.textSecondary),
        border: Color = Color(.border),
        error: Color = Color(.error),
        success: Color = Color(.success),
        warning: Color = Color(.warning),
        info: Color = Color(.info),
        disabled: Color = Color(.disabled),
        hover: Color = Color(.hover),
        pressed: Color = Color(.pressed)
    ) {
        self.primary = primary
        self.secondary = secondary
        self.background = background
        self.shadow = shadow
        self.surface = surface
        self.text = text
        self.textSecondary = textSecondary
        self.border = border
        self.error = error
        self.success = success
        self.warning = warning
        self.info = info
        self.disabled = disabled
        self.hover = hover
        self.pressed = pressed
    }
}
