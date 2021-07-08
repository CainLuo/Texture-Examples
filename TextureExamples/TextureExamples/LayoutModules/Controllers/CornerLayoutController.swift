//
//  CornerLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/8.
//

import AsyncDisplayKit

class CornerLayoutController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.backgroundColor = UIColor(0xf5f5f5)
        node.setNeedsLayout()
    }
}

extension CornerLayoutController {
    private func configBackgroundNode() {
        let contentNode = CornerContentNode()

        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: contentNode)
        }
    }
}

// MARK: - CornerContentNode
class CornerContentNode: ASDisplayNode {

    private let imageNode = ASImageNode()
    private let imageBadge = ASImageNode()
    private let textNode = ASTextNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        imageNode.image = #imageLiteral(resourceName: "image2")
        imageBadge.image = UIImage.as_resizableRoundedImage(withCornerRadius: 12, cornerColor: .clear, fill: .red)
        textNode.attributedText = NSAttributedString.attributed(" 99+ ", color: .white, fontSize: 20)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: 100, height: 100)

        let badgeSpec = ASBackgroundLayoutSpec(child: textNode, background: imageBadge)
        let corner = ASCornerLayoutSpec(child: imageNode, corner: badgeSpec, location: .topRight)

        let vStack = ASStackLayoutSpec.vertical()
        vStack.children = [corner]
        return vStack
    }
}
