//
//  ExpenseLog.swift
//  Budgeter
//
//  Created by Pasha Otverchenko on 27.12.2025.
//

import Foundation

struct ExpenseLog: Identifiable {
    var id = UUID().uuidString
    var name: String
    var amount: Double
    var date: Date
    
    static var sampleData: [ExpenseLog] {
        [
            ExpenseLog(name: "Chevron", amount: 50, date: Date()),
            ExpenseLog(name: "Arco", amount: 65.00, date: Date()),
            ExpenseLog(name: "Shell", amount: 32.00, date: Date())
        ]
    }
}
