//
//  ContentView.swift
//  Animations
//
//  Created by Matsvei Liapich on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var rotateAmount = 0.0
    
    var body: some View {
        ForEach(0..<3) { number in
            Button("Tap Me") {
                withAnimation {
                    rotateAmount += 360
                }
            }
            .padding(20)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .rotation3DEffect(.degrees(rotateAmount), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
    }
}

#Preview {
    ContentView()
}
