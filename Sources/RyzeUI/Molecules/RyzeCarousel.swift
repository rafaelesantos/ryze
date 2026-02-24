//
//  RyzeCarousel.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/02/26.
//

public struct RyzeCarousel<Item: Identifiable & Equatable, Content: View>: View {
    @Environment(\.theme) var theme
    
    let items: [Item]
    let itemWidth: CGFloat
    let spacing: RyzeSpacing
    let minimumScale: CGFloat
    let content: (Int) -> Content
    
    @Binding var selection: Int?
    
    var spacingValue: CGFloat {
        spacing.rawValue(for: theme.spacing)
    }
    
    public init(
        items: [Item],
        itemWidth: CGFloat = 160,
        spacing: RyzeSpacing = .small,
        minimumScale: CGFloat = 0.85,
        selection: Binding<Int?>,
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self.items = items
        self.itemWidth = itemWidth
        self.spacing = spacing
        self.minimumScale = minimumScale
        self._selection = selection
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let horizontalInset = (proxy.size.width / 2) - (itemWidth / 2.5) + spacingValue
            
            ScrollView(.horizontal) {
                HStack(spacing: spacingValue) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        content(index)
                            .frame(width: itemWidth)
                            .containerRelativeFrame(.horizontal)
                            .id(index)
                            .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                let scale = Self.computeScale(
                                    phaseValue: phase.value,
                                    minimumScale: minimumScale
                                )
                                
                                let opacity = Self.computeOpacity(
                                    phaseValue: phase.value
                                )
                                
                                return view
                                    .scaleEffect(scale)
                                    .opacity(opacity)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, horizontalInset)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $selection)
            .padding(.horizontal, -40)
            .animation(.bouncy(duration: 1.2), value: items)
        }
    }
    
    private static func computeScale(
        phaseValue: CGFloat,
        minimumScale: CGFloat
    ) -> CGFloat {
        let progress = 1 - abs(phaseValue)
        return minimumScale + progress * (1 - minimumScale)
    }

    private static func computeOpacity(
        phaseValue: CGFloat
    ) -> CGFloat {
        0.5 + (0.5 * (1 - abs(phaseValue)))
    }
}
