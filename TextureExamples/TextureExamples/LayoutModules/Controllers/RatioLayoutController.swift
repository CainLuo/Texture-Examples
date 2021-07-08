//
//  RatioLayoutController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class RatioLayoutController: BaseNodeController {

    var type: LayoutsSectionType = .original

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension RatioLayoutController {
    private func configBackgroundNode() {
        let contentNode = RatioContentNode()
        contentNode.type = type
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20), child: contentNode)
        }
    }
}

// MARK: - ContentNode
class RatioContentNode: ASDisplayNode {

    var type: LayoutsSectionType = .original

    let imageNode = ASImageNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        imageNode.image = #imageLiteral(resourceName: "image1")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio: CGFloat = 3.0 / 1.0
        return ASRatioLayoutSpec(ratio: ratio, child: imageNode)
    }
}

