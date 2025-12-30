//
//  GameView.swift
//  Edutainment
//
//  Created by Matsvei Liapich on 12/26/25.
//

import SwiftUI

struct GameView: View {
    let questions: [Question]
    let quit: () -> Void
    
    @State private var score: Int = 0
    @State private var currentQuestion: Int = 0
    @State private var answer: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What is \(questions[currentQuestion].multiplicand) times \(questions[currentQuestion].multiplier)?")
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
                .disabled(answer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            
            
        }
        .padding(25)
    }
    
    private func nextQuestion() {
        answer = ""
        
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            quit()
        }
    }
}

#Preview {
    GameView(questions: [Question(multiplicand: 5, multiplier: 5, correctAnswer: 25)], quit: {})
}
