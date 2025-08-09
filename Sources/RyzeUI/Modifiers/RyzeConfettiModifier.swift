//
//  RyzeConfettiModifier.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/08/25.
//

fileprivate struct RyzeConfettiView: RyzeView {
    @State var animate = false
    @State var xSpeed = Double.random(in: 0.7...2)
    @State var zSpeed = Double.random(in: 1...3)
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
    let count: Int
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
        RyzeConfettiContainerView(count: 50)
    }
}


struct RyzeConfettiModifier: RyzeViewModifier {
    @State var isActive: Bool = false
    
    let amount: Int
    let seconds: Int

    func body(content: Content) -> some View {
        content
            .overlay {
                if isActive {
                    RyzeConfettiContainerView(count: amount)
                }
            }
            .sensoryFeedback(.success, trigger: isActive)
            .animation(.linear, value: isActive)
            .onAppear { handler() }
    }
    
    func handler() {
        guard !isActive else { return }
        isActive = true
        Task {
            try await Task.sleep(for: .seconds(seconds))
            isActive = false
        }
    }
    
    static var mock: some View {
        RyzeVStack {
            
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ryzeConfetti(amount: 60)
    }
}

#Preview {
    RyzeConfettiModifier.mock
}
