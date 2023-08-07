//
//  ContentView.swift
//  Animations
//
//  Created by Matsvei Liapich on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap me") {}
        .padding(20)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                           value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

#Preview {
    ContentView()
}
