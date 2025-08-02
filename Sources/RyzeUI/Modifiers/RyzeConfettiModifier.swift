//
//  RyzeConfettiModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/08/25.
//

fileprivate struct RyzeConfettiView: RyzeView {
    @State var animate = false
    @State var xSpeed = Double.random(in: 2...3)
    @State var zSpeed = Double.random(in: 2...3)
    @State var anchor = CGFloat.random(in: 0...1).rounded()
    
    var body: some View {
        Rectangle()
            .fill(
                [
                    Color.orange,
                    Color.green,
                    Color.blue,
                    Color.red,
                    Color.yellow
                ].randomElement() ?? .green
            )
            .frame(width: 9, height: 12)
            .onAppear { animate = true }
            .rotation3DEffect(
                .degrees(animate ? 360 : 0),
                axis: (x: 1, y: 0, z: 0)
            )
            .animation(
                Animation.linear(duration: xSpeed).repeatForever(autoreverses: false),
                value: animate
            )
            .rotation3DEffect(
                .degrees(animate ? 360 : 0),
                axis: (x: 0, y: 0, z: 1),
                anchor: UnitPoint(x: anchor, y: anchor)
            )
            .animation(
                Animation.linear(duration: zSpeed).repeatForever(autoreverses: false),
                value: animate
            )
    }
    
    static var mock: some View {
        RyzeConfettiView()
    }
}

fileprivate struct RyzeConfettiContainerView: RyzeView {
    @State var count: Int = 60
    @State var yPosition: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0 ..< count, id: \.self) { _ in
                    RyzeConfettiView()
                        .position(
                            x: CGFloat.random(in: 0 ... proxy.size.width),
                            y: yPosition != .zero ? CGFloat.random(in: 0 ... proxy.size.height) : yPosition
                        )
                }
            }
            .onAppear {
                yPosition = CGFloat.random(in: 0 ... proxy.size.height)
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    static var mock: some View {
        RyzeConfettiContainerView()
    }
}

struct RyzeConfettiModifier: RyzeViewModifier {
    let isActive: Bool

    func body(content: Content) -> some View {
        content
            .overlay(isActive ? RyzeConfettiContainerView() : nil)
            .sensoryFeedback(.success, trigger: isActive)
            .animation(.easeOut(duration: 2), value: isActive)
    }
    
    static var mock: some View {
        RyzeVStack {
            
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ryzeConfetti(true)
    }
}

#Preview {
    RyzeConfettiModifier.mock
}
