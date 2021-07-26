//
//  GIFListCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/26.
//

import AsyncDisplayKit
import TextureSwiftSupport

class GIFListCellNode: ASCellNode {
    private let avatarImageNode = ASNetworkImageNode()
    private let nameNode = ASTextNode()
    private let gifImageNode = ASNetworkImageNode()
    private let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    init(_ item: GIFListModel) {
        super.init()
        automaticallyManagesSubnodes = true

        avatarImageNode.url = URL(string: item.avatar ?? "")
        avatarImageNode.style.preferredSize = CGSize(width: 40, height: 40)

        nameNode.attributedText = NSAttributedString.attributed(item.name ?? "")
        nameNode.style.flexGrow = 1.0

        gifImageNode.url = URL(string: item.image ?? "")
        gifImageNode.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gifImageNode.contentMode = .scaleAspectFit
    }
}

extension GIFListCellNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            InsetLayout(insets: insets) {
                VStackLayout(spacing: 10) {
                    HStackLayout(spacing: 10, alignItems: .center) {
                        avatarImageNode
                        nameNode
                    }
                    gifImageNode
                        .height(constrainedSize.max.width)
                }
            }
        }
    }
}
