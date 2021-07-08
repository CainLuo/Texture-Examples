//
//  OverlayLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class OverlayLayoutController: BaseNodeController {

    var type: LayoutsSectionType = .original

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension OverlayLayoutController {
    private func configBackgroundNode() {
        let contentNode = OverlayContentNode()
        contentNode.type = type
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            contentNode.style.preferredSize = CGSize(width: 300, height: 300)
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode)
        }
    }
}

// MARK: - ContentNode
class OverlayContentNode: ASDisplayNode {

    private let backgroundNode = ColorNode(UIColor.blue)
    private let foregroundNode = ColorNode(UIColor.red, size: CGSize(width: 100, height: 100))

    var type: LayoutsSectionType = .original

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        type == .original ? stackLayoutSpec() : otherLayoutSpec()
    }

    // MARK: - ASStackLayoutSpec
    private func stackLayoutSpec() -> ASLayoutSpec {
        let centerLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: foregroundNode)
        return ASOverlayLayoutSpec(child: backgroundNode, overlay: centerLayout)
    }

    // MARK: - TextureSwiftSupport
    private func otherLayoutSpec() -> ASLayoutSpec {
        LayoutSpec {
            OverlayLayout {
                backgroundNode
            } overlay: {
                CenterLayout(centeringOptions: .XY) {
                    foregroundNode
                }
            }
        }
    }
}
