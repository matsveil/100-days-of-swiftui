//
//  ContentView.swift
//  Moonshot
//
//  Created by Matsvei Liapich on 11/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("Example")
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.8
            }
    }
}

#Preview {
    ContentView()
}
