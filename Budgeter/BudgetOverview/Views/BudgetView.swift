//
//  ContentView.swift
//  Budgeter
//
//  Created by Pasha Otverchenko on 26.12.2025.
//

import SwiftUI

struct BudgetView: View {
    
    // MARK: - Properties -
    
    @State private var budget = 500.0
    @State private var isOverspent = false
    @State private var isPopoverShown = false
    
    @State private var enteredExpenseName = ""
    @State private var enteredExpenseAmount = ""
    
    
    @State private var expensesData = [
        ExpenseLog(name: "Chevron", amount: 50),
        ExpenseLog(name: "Arco", amount: 65.33),
        ExpenseLog(name: "Shell", amount: 32.00)
    ]
    
    private var remainder: CGFloat {
        guard currentBalance > 0 else { return 0 }
        return CGFloat(currentBalance) / CGFloat(budget)
    }
    
    private var currentBalance: Double {
        var spendings = 0.0
        for expense in expensesData {
            spendings += expense.amount
        }
        return budget - spendings
    }
    
    private let circleLimit = 0.7
    
    // MARK: - Methods -
    
    /// Determines the corners to be rounded based on the index
    private func corners(for index: Int) -> UIRectCorner {
        if expensesData.count == 1 {
            return .allCorners
        } else if index == 0 {
            return [.topLeft, .topRight]
        } else if index == expensesData.count - 1 {
            return [.bottomLeft, .bottomRight]
        } else {
            return []
        }
    }
    
    // MARK: - View -
    
    var body: some View {
        NavigationStack {
            
            VStack {
                ZStack {
                    VStack {
                        Text("Gas")
                            .font(.largeTitle)
                            .foregroundStyle(isOverspent ? .red : .black)
                        Text("\(currentBalance.formatted())/\(budget.formatted())")
                    }
                    Circle()
                        .trim(from: 0.0, to: circleLimit)
                        .stroke(.red, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .containerRelativeFrame(.horizontal) {width, _ in width * 0.4}
                        .containerRelativeFrame(.vertical) { height, _ in height * 0.2}
                        .rotationEffect(.degrees(-215))
                    
                    Circle()
                        .trim(from: (1.0 - remainder) * circleLimit, to: circleLimit)
                        .stroke(.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .containerRelativeFrame(.horizontal) {width, _ in width * 0.4}
                        .containerRelativeFrame(.vertical) { height, _ in height * 0.2}
                        .rotationEffect(.degrees(-215))
                        .animation(.easeIn(duration: 0.4), value: remainder)
                }
                
                List() {
                    ForEach(Array(expensesData.enumerated()), id: \.element.id) { index, log in
                        HStack {
                            Text(log.name)
                            Spacer()
                            Text("$\(log.amount.formatted())")
                        }
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.white)
//                        .clipShape(
//                            RoundedCorner(
//                                radius: 12,
//                                corners: corners(for: index)
//                            )
//                        )
//                        .listRowInsets(EdgeInsets())
//                        .listRowSeparator(index == expensesData.count - 1 ? .hidden : .visible)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.08))
                        )
                )
                
                Spacer()
            }
            .padding()
            .navigationTitle("Budgeter")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        isPopoverShown = true
                    }
                    .sheet(isPresented: $isPopoverShown, onDismiss: {
                        guard !enteredExpenseName.isEmpty && !enteredExpenseAmount.isEmpty else { return }
                        guard let enteredExpenseAmountAsDouble = Double(enteredExpenseAmount) else { return }
                        let newExpense = ExpenseLog(name: enteredExpenseName, amount: enteredExpenseAmountAsDouble)
                        expensesData.append(newExpense)
                        
                        enteredExpenseName = ""
                        enteredExpenseAmount = ""
                    }, content: {
                        NavigationStack {
                            AddExpenseView(expenseName: $enteredExpenseName, expenseAmount: $enteredExpenseAmount)
                                .presentationDetents([.medium])
                                .navigationTitle("Add expense")
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button("Done") {
                                            isPopoverShown = false
                                        }
                                    }
                                }  
                        }
                    })
                    
                }
            }
        }
    }
}

#Preview {
    BudgetView()
}

