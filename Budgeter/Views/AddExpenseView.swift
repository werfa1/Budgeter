//
//  AddExpenseView.swift
//  Budgeter
//
//  Created by Pasha Otverchenko on 28.12.2025.
//

import SwiftUI

struct AddExpenseView: View {
    
    // MARK: - Properties -
    
    @Environment(\.dismiss) private var dismiss
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    
    // MARK: - View -
    
    var body: some View {
        VStack {
            VStack {
                TextField("Enter the name of the expense", text: $expenseName)
                    .padding()
                TextField("Enter amount", text: $expenseAmount)
                    .padding()
                    .keyboardType(.numberPad)
                    .onChange(of: expenseAmount) { _, newValue in
                        let filtered = newValue.filter({ $0.isNumber })
                        if filtered != newValue {
                            self.expenseAmount = filtered
                        }
                    }
            }
            Spacer()
            
            HStack {
                Button("Add") {
                    
                    dismiss()
                }
                .padding()
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                
                Button("Close", role: .destructive) {
                    
                    dismiss()
                }
                .padding()
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
        }
    }
}

#Preview {
    AddExpenseView()
}
