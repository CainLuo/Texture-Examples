//
//  CenterLayoutController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import AsyncDisplayKit
import TextureSwiftSupport

class CenterLayoutController: BaseNodeController {

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

extension CenterLayoutController {
    private func configBackgroundNode() {
        let contentNode = CenterContentNode(type)
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            contentNode.style.preferredSize = CGSize(width: 300, height: 300)
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: contentNode)
        }
    }
}

// MARK: - ContentNode
class CenterContentNode: ASDisplayNode {

    private var type: LayoutsSectionType = .original

    init(_ type: LayoutsSectionType) {
        super.init()
        log.debug("LayoutsSectionType: \(type)")
        automaticallyManagesSubnodes = true
        backgroundColor = .gray
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let foregroundNode = ColorNode(.red, size: CGSize(width: 100, height: 100))
        return ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: foregroundNode)
    }
}

