//
//  CenterLayoutController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import AsyncDisplayKit

class CenterLayoutController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        node.automaticallyRelayoutOnSafeAreaChanges = true
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension CenterLayoutController {
    private func configBackgroundNode() {
        let contentNode = CenterContentNode()

        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            contentNode.style.preferredSize = CGSize(width: 300, height: 300)
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode)
        }
    }
}

// MARK: - ContentNode
class CenterContentNode: ASDisplayNode {

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .gray
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let foregroundNode = ColorNode(.red, size: CGSize(width: 100, height: 100))
        return ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: foregroundNode)
    }
}

