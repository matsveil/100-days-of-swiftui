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
    
    var body: some View {
        NavigationStack {
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

                Picker("Number of questions", selection: $selectedQuestionCount) {
                    ForEach(questionCount, id: \.self) { number in
                        Text(number.description).tag(number)
                    }
                }
                
                Button {
                    
                } label: {
                    Spacer()
                    Text("Start")
                    Spacer()
                }
                .buttonStyle(.glassProminent)
                .disabled(selectedMultiplicationTables.isEmpty)
            }
            .navigationTitle("Edutainment")
        }
    }
}

#Preview {
    ContentView()
}
