//
//  PhotoCollectionCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import AsyncDisplayKit

class PhotoCollectionCellNode: ASCellNode {
    private let textNode = ASTextNode()

    let contentNode = ASDisplayNode()
    let avatarImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        // Set the imageModificationBlock for a rounded avatar
        node.imageModificationBlock = ASImageNodeRoundBorderModificationBlock(0, nil)
        return node
    }()

    private lazy var photoImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        node.backgroundColor = UIColor(0xf5f5f5)
        return node
    }()

    init(_ item: PhotoTableModel) {
        super.init()
        automaticallyManagesSubnodes = true
        configUIs(item)
    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        avatarImageNode.style.preferredSize = CGSize(width: 20, height: 20)
        textNode.style.flexShrink = 1.0

        let hStack = ASStackLayoutSpec.horizontal()
        hStack.spacing = 4
        hStack.children = [avatarImageNode, textNode]

        let insetStack = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 5, bottom: 5, right: 5), child: hStack)
        let overlayContent = ASOverlayLayoutSpec(child: contentNode, overlay: insetStack)

        return ASOverlayLayoutSpec(child: photoImageNode, overlay: overlayContent)
    }
}

extension PhotoCollectionCellNode {
    private func configUIs(_ item: PhotoTableModel) {
        photoImageNode.url = URL(string: item.urls?.regular ?? "")
        avatarImageNode.url = URL(string: item.user?.profileImage?.medium ?? "")
        textNode.attributedText = NSAttributedString.attributed(item.user?.name ?? "", color: .white, fontSize: 12, alignment: .center)
        textNode.maximumNumberOfLines = 1
        contentNode.backgroundColor = UIColor(0x000000, alpha: 0.2)
    }
}
