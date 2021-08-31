//
//  PhotoIGOtherCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/8/31.
//

import Foundation
import AsyncDisplayKit
import TextureSwiftSupport

class PhotoIGOtherCellNode: ASCellNode {
    private var titleNode = ASTextNode()
    
    init(_ title: String) {
        super.init()
        automaticallyManagesSubnodes = true
        titleNode.attributedText = NSAttributedString.attributed(title, alignment: .center)
        backgroundColor = UIColor(0xF8F8F8)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            InsetLayout(insets: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)) {
                titleNode
                    .width(constrainedSize.max.width)
            }
        }
    }
}
