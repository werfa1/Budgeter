//
//  DoubleDecimalExtension.swift
//  Budgeter
//
//  Created by Pasha Otverchenko on 01.01.2026.
//

import Foundation

extension Double {
    /// Format the amount of decimals shown
    /// Parameter:
    /// - maxDecimals: the amount of decimals shown. Set to 2 by default
    func formatted(maxDecimals: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxDecimals
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
