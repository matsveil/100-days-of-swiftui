//
//  GameView.swift
//  Edutainment
//
//  Created by Matsvei Liapich on 12/26/25.
//

import SwiftUI

struct GameSettings: Hashable {
    let questionsCount: Int
    let multiplicationTables: Set<Int>
}

struct GameView: View {
    let settings: GameSettings
    let quit: () -> Void
    
    @State private var score: Int = 0
    @State private var currentQuestion: Int = 0
    @State private var multiplicand: Int = 0
    @State private var multiplier: Int = 0
    @State private var correctAnswer: Int = 0
    @State private var answer: String = ""
    @State private var returnHome: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What is \(multiplicand) times \(multiplier)?")
                .font(.title).bold()
                .foregroundStyle(.primary)
            
            HStack {
                TextField(
                    "Your answer",
                    text: $answer
                )
                .font(.title).bold()
                .foregroundStyle(.secondary)
                .keyboardType(.numberPad)
                
                Button("Check") {
                    self.nextQuestion()
                }
                .buttonStyle(.glassProminent)
                .font(.headline)
            }

            
        }
        .padding(25)
        .onAppear {
            self.generateQuestion()
        }
    }
    
    private func nextQuestion() {
        currentQuestion += 1
        answer = ""
        
        guard currentQuestion <= settings.questionsCount else {
            quit()
            return
        }
        
        generateQuestion()
    }
    
    private func generateQuestion() {
        guard let multiplicationTable = settings.multiplicationTables.randomElement() else {
            return
        }
        
        multiplicand = multiplicationTable
        let multiplierRange = 1...10
        multiplier = Int.random(in: multiplierRange)
        correctAnswer = multiplicand * multiplier
    }
}

#Preview {
    GameView(settings: GameSettings(questionsCount: 10, multiplicationTables: [2, 3, 5]), quit: {})
}
