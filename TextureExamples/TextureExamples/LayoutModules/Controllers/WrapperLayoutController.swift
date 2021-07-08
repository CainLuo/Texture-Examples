//
//  WrapperLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import UIKit
import AsyncDisplayKit

class WrapperLayoutController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.backgroundColor = .gray
        node.setNeedsLayout()
    }
}

extension WrapperLayoutController {
    private func configBackgroundNode() {
        let contentNode = WrapperContentNode()

        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: contentNode)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: centerSpec)
        }
    }
}

// MARK: - WrapperContentNode
class WrapperContentNode: ASDisplayNode {

    private lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "image2")
        node.backgroundColor = .gray
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: constrainedSize.max.width,
                                               height: constrainedSize.max.width)
        return ASWrapperLayoutSpec(layoutElement: imageNode)
    }
}
