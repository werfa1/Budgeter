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
    
    static var sampleData: [ExpenseLog] {
        [
            ExpenseLog(name: "Chevron", amount: 50),
            ExpenseLog(name: "Arco", amount: 65.00),
            ExpenseLog(name: "Shell", amount: 32.00)
        ]
    }
}
