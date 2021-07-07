//
//  ColorNode.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import AsyncDisplayKit

class ColorNode: ASDisplayNode {

    init(_ color: UIColor, size: CGSize = .zero) {
        super.init()
        isLayerBacked = true
        backgroundColor = color
        style.width = ASDimensionMakeWithPoints(size.width)
        style.height = ASDimensionMakeWithPoints(size.height)
    }
}
