//
//  RatioLayoutController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import AsyncDisplayKit

class RatioLayoutController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        node.automaticallyRelayoutOnSafeAreaChanges = true
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension RatioLayoutController {
    private func configBackgroundNode() {
        let contentNode = RatioContentNode()

        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            contentNode.style.preferredSize = CGSize(width: 300, height: 300)
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode)
        }
    }
}

// MARK: - ContentNode
class RatioContentNode: ASDisplayNode {
    
    let imageNode = ASImageNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        imageNode.image = #imageLiteral(resourceName: "image1")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio: CGFloat = 3.0 / 1.0 / 10
        return ASRatioLayoutSpec(ratio: ratio, child: imageNode)
    }
}

