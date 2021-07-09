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
        stackLayoutSpec()
    }

    // MARK: - ASStackLayoutSpec
    private func stackLayoutSpec() -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: 100, height: 100)

        let badgeSpec = ASBackgroundLayoutSpec(child: textNode, background: imageBadge)
        let corner = ASCornerLayoutSpec(child: imageNode, corner: badgeSpec, location: .topRight)
        corner.offset = CGPoint(x: -3, y: 3)

        let vStack = ASStackLayoutSpec.vertical()
        vStack.children = [corner]
        return vStack
    }

    // MARK: - TextureSwiftSupport
    private func otherLayoutSpec() {
        // TextureSwiftSupport没有ASCornerLayoutSpec这个布局方式，如果您需要的话可以自行实现或者直接使用ASCornerLayoutSpec，
        // 或者可以去https://github.com/TextureCommunity/TextureSwiftSupport给开发者提issues。

        // TextureSwiftSupport does not have ASCornerLayoutSpec layout method, you can implement it yourself if you need or use ASCornerLayoutSpec directly,
        // or you can go to https://github.com/TextureCommunity/ TextureSwiftSupport gives developers issues.
    }
}
