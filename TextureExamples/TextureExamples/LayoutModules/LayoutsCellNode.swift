//
//  LayoutsCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class LayoutsCellNode: ASCellNode {

    private let titleNode = ASTextNode()

    init(_ item: LayoutsItemModel?) {
        super.init()
        guard let item = item else {
            return
        }
        automaticallyManagesSubnodes = true
        titleNode.attributedText = NSAttributedString.attributed(item.title ?? "")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            InsetLayout(insets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)) {
                CenterLayout(centeringOptions: .Y) {
                    titleNode
                }
                .height(44)
            }
        }
    }
}
