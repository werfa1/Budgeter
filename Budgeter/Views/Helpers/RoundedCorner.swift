//
//  RoundedCorner.swift
//  Budgeter
//
//  Created by Pasha Otverchenko on 27.12.2025.
//

import Foundation
import SwiftUI

/// A helper struct that creates a rect with specified corners rounded
struct RoundedCorner: Shape {
    var radius: CGFloat = 12
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
