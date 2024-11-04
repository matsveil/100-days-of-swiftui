//
//  ContentView.swift
//  iExpense
//
//  Created by Matsvei Liapich on 8/15/23.
//

import SwiftUI

enum Currency: String, CaseIterable {
    case usd
    case eur
    case gbp
    case jpy
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Personal")) {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        ItemView(item: item)
                    }
                    .onDelete { offsets in
                        removeItems(ofType: "Personal", at: offsets)
                    }
                }
                .headerProminence(.increased)

                Section(header: Text("Business")) {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        ItemView(item: item)
                    }
                    .onDelete { offsets in
                        removeItems(ofType: "Business", at: offsets)
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func removeItems(ofType type: String, at offsets: IndexSet) {
        // Get indices of items of the specified type
        let itemsOfType = expenses.items.enumerated().filter { $0.element.type == type }
        // Map offsets to indices in the unfiltered array
        let indicesToRemove = offsets.map { itemsOfType[$0].offset }
        // Remove items at these indices
        expenses.items.remove(atOffsets: IndexSet(indicesToRemove))
    }
}

#Preview {
    ContentView()
}
