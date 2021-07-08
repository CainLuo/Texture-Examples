//
//  OverlayLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import UIKit
import AsyncDisplayKit

class OverlayLayoutController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension OverlayLayoutController {
    private func configBackgroundNode() {
        let contentNode = OverlayContentNode()

        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            contentNode.style.preferredSize = CGSize(width: 300, height: 300)
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode)
        }
    }
}

// MARK: - ContentNode
class OverlayContentNode: ASDisplayNode {

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backgroundNode = ColorNode(UIColor.blue)
        let foregroundNode = ColorNode(UIColor.red, size: CGSize(width: 100, height: 100))
        let centerLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: foregroundNode)
        return ASOverlayLayoutSpec(child: backgroundNode, overlay: centerLayout)
    }
}
