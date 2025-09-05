//
//  RyzeCurrencyTextField.swift
//  Ryze
//
//  Created by Rafael Escaleira on 02/09/25.
//

import SwiftUI
import RyzeFoundation

public struct RyzeCurrencyTextField: RyzeView {
    @Binding var amount: Double
    @State var text: String = ""
    let locale: RyzeLocale
    
    public init(
        amount: Binding<Double>,
        locale: RyzeLocale = .current
    ) {
        self._amount = amount
        self.locale = locale
    }

    public var body: some View {
        TextField("", text: $text)
            .ryze(color: amount == .zero ? .textSecondary : .text)
            .onAppear {
                if text.isEmpty {
                    text = format(amount)
                }
            }
            .onChange(of: amount) { _, newValue in
                let formatted = format(newValue)
                if formatted != text { text = formatted }
            }
            .onChange(of: text) { _, newValue in
                let digits = newValue.compactMap(\.wholeNumberValue)
                let value = digits.reduce(0) { $0.double * 10 + $1.double } / 100
                if value != amount { amount = value }
                let masked = format(value)
                if masked != newValue { text = masked }
            }
    }

    func format(_ amount: Double) -> String {
        let number = NSDecimalNumber(value: amount)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = locale.currencyCode
        numberFormatter.locale = locale.rawValue
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: number) ?? ""
    }
    
    public static var mock: some View {
        RyzeCurrencyTextField(
            amount: .constant(.zero),
            locale: .current
        )
    }
}

#Preview {
    @Previewable @State var amount: Double = .zero
    RyzeCurrencyTextField(amount: $amount)
}
