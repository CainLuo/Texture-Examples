//
//  InsetLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class InsetLayoutController: BaseNodeController {

    var type: LayoutsSectionType = .original

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension InsetLayoutController {
    private func configBackgroundNode() {
        let contentNode = InsetLayoutContentNode()
        contentNode.type = type
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                              child: contentNode)
        }
    }
}

// MARK: - ContentNode
class InsetLayoutContentNode: ASDisplayNode {

    var type: LayoutsSectionType = .original

    private let backgroundNode = ASDisplayNode()
    private lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "image1")
        node.backgroundColor = .gray
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundNode.backgroundColor = .gray
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        type == .original ? stackLayoutSpec() : otherLayoutSpec()
    }

    // MARK: - ASStackLayoutSpec
    private func stackLayoutSpec() -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: .infinity, right: 10),
                                      child: imageNode)

        return ASBackgroundLayoutSpec(child: inset, background: backgroundNode)
    }

    // MARK: - TextureSwiftSupport
    private func otherLayoutSpec() -> ASLayoutSpec {
        LayoutSpec {
            BackgroundLayout {
                InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: .infinity, right: 10)) {
                    imageNode
                }
            } background: {
                backgroundNode
            }
        }
    }
}
