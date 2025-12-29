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
        case game(GameSettings)
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
                        let settings = GameSettings(
                            questionsCount: selectedQuestionCount,
                            multiplicationTables: selectedMultiplicationTables
                        )
                        
                        path.append(.game(settings))
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
                case .game(let settings):
                    GameView(settings: settings) {
                        path    .removeAll()
                    }
                }
            }
            .navigationTitle("Edutainment")
        }
    }
}

#Preview {
    ContentView()
}
