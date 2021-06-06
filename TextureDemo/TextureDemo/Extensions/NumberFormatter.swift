//
//  NumberFormatter.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import Foundation

extension NumberFormatter {
    static let decimalNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
