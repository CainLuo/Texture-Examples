//
//  ASUIListsCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit
import TextureSwiftSupport

class ASUIListsCellNode: ASCellNode {

    private let titleNode = ASTextNode()

    init(_ model: ASUIListsModel?) {
        super.init()
        guard let model = model else {
            return
        }
        automaticallyManagesSubnodes = true
        titleNode.attributedText = NSAttributedString.attributed(model.title ?? "")
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
