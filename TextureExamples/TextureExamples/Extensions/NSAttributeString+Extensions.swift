//
//  NSAttributeString+Extensions.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import UIKit
import Foundation

extension NSAttributedString {
    /// 配置NSAttributedString的颜色、字体大小、内容、NSTextAlignment
    /// - Parameters:
    ///   - color: UIColor, default: 0x333333
    ///   - fontSize: CGFloat
    ///   - content: String
    ///   - alignment: NSTextAlignment, default: .left
    /// - Returns: NSAttributedString
    static func attributed(_ content: String, color: UIColor = UIColor(0x333333),
                           fontSize: CGFloat = 16, alignment: NSTextAlignment = .left,
                           isBold: Bool = false) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        let keys = [
            NSAttributedString.Key.font: isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.paragraphStyle: style
        ]
        return NSAttributedString(string: content, attributes: keys)
    }
}
