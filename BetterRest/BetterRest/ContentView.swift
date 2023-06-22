//
//  ContentView.swift
//  BetterRest
//
//  Created by Matsvei Liapich on 3/26/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Your ideal bed time is...")
                            .font(.headline)
                            .fontDesign(.rounded)
                        Text(calculateBedtime())
                            .font(.largeTitle)
                            .bold()
                            .fontDesign(.rounded)
                            .foregroundColor(.cyan)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Desired wake up time")
                        .font(.headline)
                        .fontDesign(.rounded)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                        .fontDesign(.rounded)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading) {
                    Text("Coffee intake in cups")
                        .font(.headline)
                        .fontDesign(.rounded)
                    
                    Picker("", selection: $coffeeAmount) {
                        ForEach(1...5, id: \.self) { coffeeAmount in
                            Text("\(coffeeAmount)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
            
            return bedTime
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, these was a problem calculating your bedtime."
        }
        
        showingAlert = true
        
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
