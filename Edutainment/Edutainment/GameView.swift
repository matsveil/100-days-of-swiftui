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
    @State private var correctAnswer: Bool = false
    @State private var wrongAnswer: Bool = false
    @State private var gameOver: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(currentQuestion + 1)/\(questions.count): What is \(questions[currentQuestion].multiplicand) times \(questions[currentQuestion].multiplier)?")
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
                    isCorrectAnswer()
                }
                .buttonStyle(.glassProminent)
                .font(.headline)
                .disabled(Int(answer.trimmingCharacters(in: .whitespacesAndNewlines)) == nil)
            }
            
            
        }
        .padding()
        .alert("Correct answer", isPresented: $correctAnswer) {
            Button("Continue", action: nextQuestion)
        } message: {
            Text("Nice")
        }
        .alert("Wrong answer", isPresented: $wrongAnswer) {
            Button("Continue", action: nextQuestion)
        } message: {
            Text("Oops")
        }
        .alert("Game over", isPresented: $gameOver) {
            Button("Go home", action: quit)
        } message: {
            Text("Your final score was \(score).")
        }
    }
    
    private func nextQuestion() {
        answer = ""
        
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            gameOver.toggle()
        }
    }
    
    private func isCorrectAnswer() {
        let isCorrect = Int(answer.trimmingCharacters(in: .whitespacesAndNewlines)) == questions[currentQuestion].correctAnswer
        
        if isCorrect {
            correctAnswer.toggle()
            score += 1
        } else {
            wrongAnswer.toggle()
        }
    }
}

#Preview {
    GameView(questions: [Question(multiplicand: 5, multiplier: 5, correctAnswer: 25)], quit: {})
}
