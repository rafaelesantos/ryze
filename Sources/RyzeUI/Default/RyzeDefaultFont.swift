//
//  RyzeDefaultFont.swift
//  Ryze
//
//  Created by Rafael Escaleira on 19/04/25.
//

struct RyzeDefaultFont: RyzeFontProtocol {
    var largeTitle: Font {
        font(
            family: family(name: .moderatBold),
            relativeTo: .largeTitle
        )
    }
    
    var title: Font {
        font(
            family: family(name: .moderatMedium),
            relativeTo: .title
        )
    }
    
    var title2: Font {
        font(
            family: family(name: .moderatMedium),
            relativeTo: .title2
        )
    }
    
    var title3: Font {
        font(
            family: family(name: .moderatMedium),
            relativeTo: .title3
        )
    }
    
    var headline: Font {
        font(
            family: family(name: .moderatBold),
            relativeTo: .headline
        )
    }
    
    var subheadline: Font {
        font(
            family: family(name: .moderatRegular),
            relativeTo: .subheadline
        )
    }
    
    var body: Font {
        font(
            family: family(name: .moderatRegular),
            relativeTo: .body
        )
    }
    
    var callout: Font {
        font(
            family: family(name: .moderatRegular),
            relativeTo: .callout
        )
    }
    
    var footnote: Font {
        font(
            family: family(name: .moderatLight),
            relativeTo: .footnote
        )
    }
    
    var caption: Font {
        font(
            family: family(name: .moderatLight),
            relativeTo: .caption
        )
    }
    
    private func font(
        family: RyzeFontFamilyProtocol,
        relativeTo textStyle: Font.TextStyle
    ) -> Font {
        .custom(
            family.rawValue,
            size: size(relativeTo: textStyle),
            relativeTo: textStyle
        )
    }
    
    private func family(name: RyzeDefaultFontFamily) -> RyzeFontFamilyProtocol {
        name
    }
    
    private func size(relativeTo textStyle: Font.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .subheadline: return 15
        case .body: return 17
        case .callout: return 16
        case .footnote: return 13
        case .caption: return 12
        case .caption2: return 11
        default: return 17
        }
    }
}
