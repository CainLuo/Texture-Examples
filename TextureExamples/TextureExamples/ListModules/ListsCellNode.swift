//
//  ListsCellNode.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/5.
//

import AsyncDisplayKit
import TextureSwiftSupport

class ListsCellNode: ASCellNode {
    
    private let titleNode = ASTextNode()
    
    init(_ item: ListsItemsModel?) {
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
