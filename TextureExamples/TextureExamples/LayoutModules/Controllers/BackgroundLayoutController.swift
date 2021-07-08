//
//  BackgroundLayoutController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class BackgroundLayoutController: BaseNodeController {

    var type: LayoutsSectionType = .original

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension BackgroundLayoutController {
    private func configBackgroundNode() {
        let contentNode = BackgroundContentNode()
        contentNode.type = type
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            contentNode.style.preferredSize = CGSize(width: 300, height: 300)
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode)
        }
    }
}

// MARK: - ContentNode
class BackgroundContentNode: ASDisplayNode {

    private let backgroundNode = ColorNode(.blue)
    private let foregroundNode = ColorNode(.red, size: CGSize(width: 100, height: 100))
    private let spacing: CGFloat = 20

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
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: spacing, left: spacing, bottom: -spacing, right: -spacing), child: foregroundNode)
        return ASBackgroundLayoutSpec(child: insetLayout, background: backgroundNode)
    }

    // MARK: - TextureSwiftSupport
    private func otherLayoutSpec() -> ASLayoutSpec {
        LayoutSpec {
            BackgroundLayout {
                InsetLayout(insets: UIEdgeInsets(top: spacing, left: spacing, bottom: -spacing, right: -spacing)) {
                    foregroundNode
                }
            } background: {
                backgroundNode
            }
        }
    }
}

