//
//  ContentView.swift
//  MultiJoy
//
//  Created by Matsvei Liapich on 8/9/23.
//

import SwiftUI

struct ContentView: View {
    let numberOfQuestions = [5, 10, 20]
    @State private var num1 = Int.random(in: 1..<11)
    @State private var num2 = Int.random(in: 1..<11)
    
    @State private var selectedNumberOfQuestios = 5
    @State private var selectedLevel = "easy"
    @State private var answer = ""
    @State private var questionNumber = 1
    @State private var isCorrect = false
    @FocusState var isActive: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Difficulty Level")
                .font(.title2)
                .bold()

            HStack {
                Button {
                    selectedLevel = "easy"
                } label: {
                    Text("easy").bold()
                }
                .buttonStyle(.borderedProminent)
                .opacity(selectedLevel == "easy" ? 1 : 0.5)
                .animation(.default, value: selectedLevel)
                
                Button {
                    selectedLevel = "mid"
                } label: {
                    Text("mid").bold()
                }
                .buttonStyle(.borderedProminent)
                .opacity(selectedLevel == "mid" ? 1 : 0.5)
                .animation(.default, value: selectedLevel)
                
                Button {
                    selectedLevel = "hard"
                } label: {
                    Text("hard").bold()
                }
                .buttonStyle(.borderedProminent)
                .opacity(selectedLevel == "hard" ? 1 : 0.5)
                .animation(.default, value: selectedLevel)
            }
            
            Text("How many questions?")
                .font(.title2)
                .bold()
                .padding(.top)
            
            Picker("Selected number of questions", selection: $selectedNumberOfQuestios) {
                ForEach(numberOfQuestions, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.segmented)
            
            Spacer()
            
            HStack {
                Image(systemName: "\(questionNumber).circle.fill")
                Text("\(num1) x \(num2) =")
                TextField("?", text: $answer)
                    .fontDesign(.rounded)
                    .keyboardType(.numberPad)
                    .focused($isActive)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()

                                Button("Done") {
                                    if Int(answer) == (num1 * num2) {
                                        isActive = false
                                        questionNumber += 1
                                        answer = ""
                                        num1 = Int.random(in: 1..<11)
                                        num2 = Int.random(in: 1..<11)
                                        
                                    } else {
                                        //
                                    }
                                }
                                .font(.headline)
                            }
                        }
                Text(Int(answer) == (num1 * num2) ? Image(systemName: "checkmark.square") : Image(systemName: "square"))
            }
            .padding()
            .font(.title)
            .bold()
            .background(Int(answer) == (num1 * num2) ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .animation(.default, value: answer)

            Spacer()
            Spacer()
            Spacer()


            
        }
        .padding(30)
    }
}

#Preview {
    ContentView()
}
