//
//  ItemView.swift
//  iExpense
//
//  Created by Matsvei Liapich on 11/4/24.
//

import SwiftUI

struct ItemView: View {
    let item: ExpenseItem
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.type)
            }
            
            Spacer(minLength: 0)
            
            Text(item.amount, format: .currency(code: item.currency.uppercased()))
                .amountStyle(item.amount)
        }
    }
}
