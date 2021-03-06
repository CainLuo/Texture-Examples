//
//  StackLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class StackLayoutController: BaseNodeController {

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

extension StackLayoutController {
    private func configBackgroundNode() {
        let contentNode = StackContentNode(type)
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: contentNode)
        }
    }
}

// MARK: - StackContentNode
class StackContentNode: ASDisplayNode {

    private lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "image1")
        node.backgroundColor = .gray
        return node
    }()

    private lazy var imageNode1: ASImageNode = {
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
        backgroundColor = .gray
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        type == .original ? stackLayoutSpec() : otherLayoutSpec()
    }

    // MARK: - ASStackLayoutSpec
    private func stackLayoutSpec() -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 6.0,
                                       justifyContent: .center,
                                       alignItems: .center,
                                       children: [imageNode, imageNode1])

        hStack.style.minWidth = ASDimensionMakeWithPoints(60.0)
        hStack.style.maxHeight = ASDimensionMakeWithPoints(40.0)
        return hStack
    }

    // MARK: - TextureSwiftSupport
    private func otherLayoutSpec() -> ASLayoutSpec {
        let layoutSpec: ASLayoutSpec = LayoutSpec {
            VStackLayout(spacing: 6.0, justifyContent: .center, alignItems: .center) {
                imageNode
                imageNode1
            }
        }

        layoutSpec.style.minWidth = ASDimensionMakeWithPoints(60.0)
        layoutSpec.style.maxHeight = ASDimensionMakeWithPoints(40.0)
        return layoutSpec
    }
}
