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
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Difficulty Level")
                .font(.title)
                .bold()
                .fontDesign(.rounded)

            HStack {
                Button("Easy") {
                    //
                }
                .padding(20)
                .background(.green)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                Button("Mid") {
                    //
                }
                .padding(20)
                .background(.orange)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                Button("Hard") {
                    //
                }
                .padding(20)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
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
        }
        .padding(40)

    }
}

#Preview {
    ContentView()
}
