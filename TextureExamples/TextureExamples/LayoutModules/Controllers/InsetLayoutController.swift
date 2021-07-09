//
//  InsetLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class InsetLayoutController: BaseNodeController {

    private var type: LayoutsSectionType = .original

    init(_ type: LayoutsSectionType) {
        super.init()
        self.type = type
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension InsetLayoutController {
    private func configBackgroundNode() {
        let contentNode = InsetLayoutContentNode(type)
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                              child: contentNode)
        }
    }
}

// MARK: - ContentNode
class InsetLayoutContentNode: ASDisplayNode {

    private let backgroundNode = ASDisplayNode()
    private lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "image1")
        node.backgroundColor = .gray
        return node
    }()

    private var type: LayoutsSectionType = .original

    init(_ type: LayoutsSectionType) {
        super.init()
        log.debug("LayoutsSectionType: \(type)")
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
