//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matsvei Liapich on 3/9/23.
//

import SwiftUI

struct FlagImage: View {
    var flagName: String
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .shadow(color: Color("Gunmetal"), radius: 25)
    }
}

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .foregroundColor(Color("Powder Blue"))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded, weight: .bold))
    }
}

struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("French Grey"))
            .font(.headline.weight(.bold))
    }
}

extension View {
    func largeTitleStyle() -> some View {
        modifier(LargeTitle())
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

extension View {
    func subtitleStyle() -> some View {
        modifier(Subtitle())
    }
}

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
                Spacer()
                
                Text("Guess The Flag")
                    .largeTitleStyle()
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the Flag Of")
                            .subtitleStyle()
                        Text(countries[correctAnswer])
                            .titleStyle()
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flagName: countries[number])

                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                Spacer()
                
                Text("Score: \(score) of \(question)")
                    .largeTitleStyle()
                

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
            score += 1
            scoreTitle = "Game Over"
            scoreMessage = "Your final score was \(score)."
            buttonMessage = "Play Again"
            gameOver = true
            score = 0
            question = 0
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
