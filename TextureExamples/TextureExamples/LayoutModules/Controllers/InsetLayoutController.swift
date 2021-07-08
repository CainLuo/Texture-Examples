//
//  InsetLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import UIKit
import AsyncDisplayKit

class InsetLayoutController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension InsetLayoutController {
    private func configBackgroundNode() {
        let contentNode = InsetLayoutContentNode()
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                     child: contentNode)
        }
    }
}

// MARK: - ContentNode
class InsetLayoutContentNode: ASDisplayNode {
    private let backgroundNode = ASDisplayNode()
    private lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "image1")
        node.backgroundColor = .gray
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundNode.backgroundColor = .gray
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: .infinity, right: 10),
                                      child: imageNode)

        return ASBackgroundLayoutSpec(child: inset, background: backgroundNode)
    }
}
