//
//  AmountStyle.swift
//  iExpense
//
//  Created by Matsvei Liapich on 11/4/24.
//

import SwiftUI

struct AmountStyleModifier: ViewModifier {
    let amount: Double
    var style: Color {
        switch amount {
        case 0...100: return .green
        case 101...200: return .yellow
        default: return .red
        }
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(style)
    }
}

extension Text {
    func amountStyle(_ amount: Double) -> some View {
        modifier(AmountStyleModifier(amount: amount))
    }
}


