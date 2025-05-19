//
//  RefdsButtonStyle.swift
//  Refds
//
//  Created by Rafael Escaleira on 26/04/25.
//

@_exported import SwiftUI


public struct RefdsButtonStyle: ButtonStyle {
    @Environment(\.refdsTheme) private var theme
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .refdsPadding(.medium)
            .frame(maxWidth: .infinity)
            .background(background(for: configuration))
            .animation(theme.animation, value: configuration.isPressed)
    }
    
    func background(for configuration: Configuration) -> some View {
        ZStack {
            Capsule()
                .fill(.clear)
                .overlay {
                    AngularGradient(
                        colors: theme.glassmorphic.colors,
                        center: .center
                    )
                }
                .padding(configuration.isPressed ? 4 : 8)
                .blur(radius: 10)
            
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemBackground).opacity(1),
                    Color(.systemBackground).opacity(0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(.capsule)
            .blendMode(.softLight)
        }
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}


#Preview {
    Button {
        
    } label: {
        Text(verbatim: .refdsPreviewTitle)
            .font(.headline)
            .bold()
    }
    .buttonStyle(RefdsButtonStyle())
    .padding(40)
}
