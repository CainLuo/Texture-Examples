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
    private var titleNode = ASButtonNode()
    
    init(_ title: String) {
        super.init()
        automaticallyManagesSubnodes = true
//        titleNode.attributedText = NSAttributedString.attributed(title, alignment: .center)
        titleNode.setTitle(title, with: UIFont.systemFont(ofSize: 14), with: .black, for: .normal)
        titleNode.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
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
    
    @objc func buttonAction() {
        log.debug("123123")
        titleNode.style.height = ASDimensionMake(100)
        setNeedsLayout()
    }
}
