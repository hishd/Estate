//
//  NumberCommaSeperator.swift
//  Estate
//
//  Created by Hishara Dilshan on 2022-04-13.
//

import Foundation

extension String {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: Double(self) ?? 0))!
    }
    
    func extractInMillions() -> String {
        let amount: Double = (Double(self) ?? 0) / 1000000
        return String(format: "%.2f million", amount)
    }
}
