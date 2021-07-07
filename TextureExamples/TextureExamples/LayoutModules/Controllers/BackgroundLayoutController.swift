//
//  BackgroundLayoutController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import AsyncDisplayKit

class BackgroundLayoutController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        node.automaticallyRelayoutOnSafeAreaChanges = true
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension BackgroundLayoutController {
    private func configBackgroundNode() {
        let contentNode = BackgroundContentNode()

        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            contentNode.style.preferredSize = CGSize(width: 300, height: 300)
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode)
        }
    }
}

// MARK: - ContentNode
class BackgroundContentNode: ASDisplayNode {

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backgroundNode = ColorNode(.blue)
        let foregroundNode = ColorNode(.red, size: CGSize(width: 100, height: 100))
        let spacing: CGFloat = 20
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: spacing, left: spacing, bottom: -spacing, right: -spacing), child: foregroundNode)
        return ASBackgroundLayoutSpec(child: insetLayout, background: backgroundNode)
    }
}

