//
//  ContentView.swift
//  MultiJoy
//
//  Created by Matsvei Liapich on 8/9/23.
//

import SwiftUI

struct ContentView: View {
    let numberOfQuestions = [5, 10, 20]
    @State private var selectedNumberOfQuestios = 5
    @State private var selectedLevel = "Easy"
    @State private var answer = ""
    @FocusState var isInputActive: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Difficulty Level")
                .font(.title)
                .bold()
                .fontDesign(.rounded)

            HStack {
                Button {
                    selectedLevel = "Easy"
                } label: {
                    Text("Easy").bold()
                }
                .padding()
                .background(.green)
                .foregroundStyle(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .opacity(selectedLevel == "Easy" ? 1 : 0.25)
                .animation(.default, value: selectedLevel)
                
                Button {
                    selectedLevel = "Mid"
                } label: {
                    Text("Mid").bold()
                }
                .padding()
                .background(.orange)
                .foregroundStyle(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .opacity(selectedLevel == "Mid" ? 1 : 0.25)
                .animation(.default, value: selectedLevel)
                
                Button {
                    selectedLevel = "Hard"
                } label: {
                    Text("Hard").bold()
                }
                .padding()
                .background(.red)
                .foregroundStyle(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .opacity(selectedLevel == "Hard" ? 1 : 0.25)
                .animation(.default, value: selectedLevel)
                
            }
            
            Text("How many questions?")
                .font(.title)
                .bold()
                .fontDesign(.rounded)
            
            Picker("Selected number of questions", selection: $selectedNumberOfQuestios) {
                ForEach(numberOfQuestions, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.segmented)
            
            Spacer()
            Spacer()
            Spacer()
            
            List {
                ForEach(1...selectedNumberOfQuestios, id: \.self) { index in
                    HStack {
                        Text("\(index).    \(generateProblem(level: selectedLevel))")
                        TextField("", text: $answer)
                            .keyboardType(.numberPad)
                            .focused($isInputActive)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.inset)
            .animation(.smooth, value: selectedNumberOfQuestios)
        }
        .padding(40)

    }
    
    func generateProblem(level: String) -> String {
        let easyNumber = Int.random(in: 1..<11)
        let easyNumber2 = Int.random(in: 1..<11)
        
        let midNumber = Int.random(in: 1..<101)
        let midNumber2 = Int.random(in: 1..<101)
        
        let hardNumber = Int.random(in: 1..<1001)
        let hardNumber2 = Int.random(in: 1..<1001)
        
        switch level {
        case "Easy":
            return "\(easyNumber) x \(easyNumber2) = "
        case "Mid":
            return "\(midNumber) x \(midNumber2) = "
        case "Hard":
            return "\(hardNumber) x \(hardNumber2) = "
        default:
            return "\(easyNumber) x \(easyNumber2) = "
        }
    }
}

#Preview {
    ContentView()
}
