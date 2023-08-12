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
    @State private var selectedLevel = "Easy"
    @State private var answer = ""
    @State private var questionNumber = 1
    
    @FocusState var isActive: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Difficulty Level")
                .font(.title2)
                .bold()

            HStack {
                Button {
                    selectedLevel = "Easy"
                    num1 = Int.random(in: 1..<11)
                    num2 = Int.random(in: 1..<11)
                } label: {
                    Text("Easy").bold()
                }
                .padding()
                .background(.regularMaterial)
                .foregroundColor(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .opacity(selectedLevel == "Easy" ? 1 : 0.5)
                .animation(.default, value: selectedLevel)
                
                Button {
                    selectedLevel = "Mid"
                    num1 = Int.random(in: 1..<51)
                    num2 = Int.random(in: 1..<51)
                } label: {
                    Text("Mid").bold()
                }
                .padding()
                .background(.regularMaterial)
                .foregroundColor(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .opacity(selectedLevel == "Mid" ? 1 : 0.5)
                .animation(.default, value: selectedLevel)
                
                Button {
                    selectedLevel = "Hard"
                    num1 = Int.random(in: 1..<101)
                    num2 = Int.random(in: 1..<101)
                } label: {
                    Text("Hard").bold()
                }
                .padding()
                .background(.regularMaterial)
                .foregroundColor(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .opacity(selectedLevel == "Hard" ? 1 : 0.5)
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
                                    if questionNumber < selectedNumberOfQuestios {
                                        questionNumber += 1
                                    } else {
                                        questionNumber = 0
                                    }
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
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .font(.title2)
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
