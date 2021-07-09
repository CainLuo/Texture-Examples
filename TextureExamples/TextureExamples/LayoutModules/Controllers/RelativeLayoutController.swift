//
//  RelativeLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/8.
//

import AsyncDisplayKit
import TextureSwiftSupport

class RelativeLayoutController: BaseNodeController {

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

extension RelativeLayoutController {
    private func configBackgroundNode() {
        let contentNode = RelativeContentNode(type)
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20), child: contentNode)
        }
    }
}

// MARK: -  RelativeContentNode
class RelativeContentNode: ASDisplayNode {

    private var type: LayoutsSectionType = .original

    init(_ type: LayoutsSectionType) {
        super.init()
        log.debug("LayoutsSectionType: \(type)")
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backgroundNode = ColorNode(UIColor.blue)
        let foregroundNode = ColorNode(UIColor.red, size: CGSize(width: 70.0, height: 100.0))

        let relativeSpec = ASRelativeLayoutSpec(horizontalPosition: .start,
                                                verticalPosition: .start,
                                                sizingOption: [],
                                                child: foregroundNode)

        return ASBackgroundLayoutSpec(child: relativeSpec, background: backgroundNode)
    }
}
