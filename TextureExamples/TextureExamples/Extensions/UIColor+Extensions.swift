//
//  UIColor+Extensions.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/29.
//

import UIKit
import Foundation

extension UIColor {
    @objc public class func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    @objc public convenience init(_ hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex >> 16) & 0xFF)
        let green = CGFloat((hex >> 8) & 0xFF)
        let blue = CGFloat(hex & 0xFF)
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }

    static var mainBarTintColor: UIColor {
        UIColor(red: 69/255, green: 142/255, blue: 255/255, alpha: 1)
    }

    static var randomColor: UIColor {
        UIColor(red: CGFloat(arc4random() % UInt32(256.0)) / 256.0,
                green: CGFloat(arc4random() % UInt32(256.0)) / 256.0,
                blue: CGFloat(arc4random() % UInt32(256.0)) / 256.0,
                alpha: 1)
    }
}
