//
//  AddView.swift
//  iExpense
//
//  Created by Matsvei Liapich on 8/8/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = Currency.usd
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.rawValue.uppercased()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $currency) {
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Text(currency.rawValue.uppercased())
                    }
                }
                
                TextField("Amount", value: $amount, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, currency: currency.rawValue.uppercased(), amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
