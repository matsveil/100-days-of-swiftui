//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matsvei Liapich on 3/12/23.
//

import SwiftUI

struct ContentView: View {
    var moves = ["Rock", "Paper", "Scissors"]
    @State private var appsMove = Int.random(in: 0...2)
    @State private var app = ""
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var question = 0
        
    var body: some View {
        NavigationView {
            VStack {
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                HStack(spacing: 10) {
                                        
                    VStack {
                        Text("YOU SHOULD")
                            .font(.footnote)
                        Text(shouldWin ? "Win" : "Lose")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    
                    VStack(alignment: .center) {
                        Text("APP'S MOVE")
                            .font(.subheadline)
                        Text(moves[appsMove])
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    
                    VStack {
                        Text("SCORE")
                            .font(.subheadline)
                        Text(String(score))
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
                
                VStack(spacing: 20) {
                    Button("🪨", action: rockVsApp)
                        .font(.system(size: 100))
                    Button("📄", action: paperVsApp)
                        .font(.system(size: 100))
                    Button("✂️", action: scissorsVsApp)
                        .font(.system(size: 100))
                }

            }
        }
    }
    
    func rockVsApp() {
        app = moves[appsMove]
        
        if shouldWin {
            if app == "Scissors" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if app == "Paper" {
                score += 1
            } else {
                score -= 1
            }
        }
        
        shouldWin.toggle()
    }
        
    func paperVsApp() {
        app = moves[appsMove]
        
        if shouldWin {
            if app == "Scissors" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if app == "Paper" {
                score += 1
            } else {
                score -= 1
            }
        }
        
        shouldWin.toggle()
    }
        
    func scissorsVsApp() {
        app = moves[appsMove]

        
        if shouldWin {
            if app == "Scissors" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if app == "Paper" {
                score += 1
            } else {
                score -= 1
            }
        }
        
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
