//
//  ContentView.swift
//  Edutainment
//
//  Created by Matsvei Liapich on 12/25/25.
//

import SwiftUI

struct ContentView: View {
    let questionCount = [5, 10, 20]
    @State private var selectedQuestionCount: Int = 5
    @State private var selectedMultiplicationTables = Set<Int>()
    @State private var path: [Route] = []
    
    enum Route: Hashable {
        case game([Question])
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section("Select tables") {
                    ForEach(1..<11, id: \.self) { number in
                        Button {
                            if selectedMultiplicationTables.contains(number) {
                                selectedMultiplicationTables.remove(number)
                            } else {
                                selectedMultiplicationTables.insert(number)
                            }
                        } label: {
                            HStack {
                                Text("\(number) x table")
                                    .foregroundStyle(.foreground)
                                
                                Spacer()
                                
                                if selectedMultiplicationTables.contains(number) {
                                    Image(systemName: "checkmark.circle.fill")
                                } else {
                                    Image(systemName: "circle")
                                }
                            }
                        }
                    }
                }
                
                Section {
                    
                    Picker("Number of questions", selection: $selectedQuestionCount) {
                        ForEach(questionCount, id: \.self) { number in
                            Text(number.description).tag(number)
                        }
                    }
                }
                
                Section {
                    
                    Button {
                        let questions = generateQuestions()
                        
                        path.append(.game(questions))
                    } label: {
                        Spacer()
                        Text("Start")
                        Spacer()
                    }
                    .buttonStyle(.glassProminent)
                    .disabled(selectedMultiplicationTables.isEmpty)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .game(let questions):
                    GameView(questions: questions) {
                        path.removeAll()
                    }
                }
            }
            .navigationTitle("Edutainment")
        }
    }
    
    private func generateQuestions() -> [Question] {
        var questions: [Question] = []
        
        for _ in 0..<selectedQuestionCount {
            let multiplicand = selectedMultiplicationTables.randomElement() ?? 0
            
            let multiplierRange = 1...10
            let multiplier = Int.random(in: multiplierRange)
            let correctAnswer = multiplicand * multiplier
            
            let question = Question(
                multiplicand: multiplicand,
                multiplier: multiplier,
                correctAnswer: correctAnswer
                
            )
            
            questions.append(question)
        }
        
        return questions
    }
}

#Preview {
    ContentView()
}
