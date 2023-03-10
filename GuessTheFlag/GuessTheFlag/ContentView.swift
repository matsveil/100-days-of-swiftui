//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matsvei Liapich on 3/9/23.
//

// 1. Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
// 2. When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
// 3. Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.

import SwiftUI

struct ContentView: View {
    @State private var gameOver = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var buttonMessage = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var question = 0
    
    var body: some View {
        ZStack {
            Color("Gunmetal")
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .foregroundColor(Color("Powder Blue"))
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the Flag Of")
                            .foregroundColor(Color("French Grey"))
                            .font(.headline.weight(.bold))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .shadow(radius: 25)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score) / \(question)")
                    .foregroundColor(Color("Powder Blue"))
                    .font(.title.bold())
                
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $gameOver) {
            Button(buttonMessage, action: shuffleFlags)
        } message: {
            Text(scoreMessage)
        }
        .preferredColorScheme(.dark)
    }
    
    func flagTapped(_ number: Int) {
        if question < 7 {
            if number == correctAnswer {
                score += 1
                question += 1
                shuffleFlags()
            } else {
                scoreTitle = "Wrong"
                scoreMessage = "You selected \(countries[number])."
                buttonMessage = "Continue"
                question += 1
                gameOver = true
            }
        } else {
            scoreTitle = "Game Over"
            scoreMessage = "Your final score is \(score)."
            score = 0
            question = 0
            gameOver = true
        }
    }

    func shuffleFlags() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
