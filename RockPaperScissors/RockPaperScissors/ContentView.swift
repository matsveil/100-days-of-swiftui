//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matsvei Liapich on 3/12/23.
//

import SwiftUI

struct ContentView: View {
    var moves = ["Rock", "Paper", "Scissors"]
    @State private var app = ""
    @State private var win = false
        
    var body: some View {
        VStack {
            Button("Rock", action: rockVsApp)
            Button("Paper", action: paperVsApp)
            Button("Scissors", action: scissorsVsApp)
        }
    }
    
    func rockVsApp() {
        app = moves[Int.random(in: 0...2)]
    }
    
    func paperVsApp() {
        app = moves[Int.random(in: 0...2)]
    }
    
    func scissorsVsApp() {
        app = moves[Int.random(in: 0...2)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
