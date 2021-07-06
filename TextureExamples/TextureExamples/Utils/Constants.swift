//
//  Constants.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import UIKit

struct Constants {
    struct CellLayout {
        static let FontSize: CGFloat = 14
        static let HeaderHeight: CGFloat = 50
        static let UserImageHeight: CGFloat = 30
        static let HorizontalBuffer: CGFloat = 10
        static let VerticalBuffer: CGFloat = 5
        static let InsetForAvatar = UIEdgeInsets(top: HorizontalBuffer, left: 0, bottom: HorizontalBuffer, right: HorizontalBuffer)
        static let InsetForHeader = UIEdgeInsets(top: 0, left: HorizontalBuffer, bottom: 0, right: HorizontalBuffer)
        static let InsetForFooter = UIEdgeInsets(top: VerticalBuffer, left: HorizontalBuffer, bottom: VerticalBuffer, right: HorizontalBuffer)
    }
}
