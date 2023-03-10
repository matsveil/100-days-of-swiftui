//
//  ContentView.swift
//  WeSplit
//
//  Created by Matsvei Liapich on 3/8/23.
//

import SwiftUI



struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercetage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: [Double] {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercetage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return [amountPerPerson, grandTotal]
    }
    
    var localCurrency: FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
    }
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<16) {
                            Text("\($0) People")
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercetage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How Much Tip Do You Want To Leave?")
                }
                
                Section {
                    Text(totalAmount[0], format: localCurrency)
                } header: {
                    Text("Amount Per Person")
                }
                
                Section {
                    Text(totalAmount[1], format: localCurrency)
                        .foregroundColor(tipPercetage == 0 ? .red : .blue)
                    
                } header: {
                    Text("Total Amount")
                }
            }
            .navigationTitle("Split Your Check")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
