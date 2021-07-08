//
//  AbsoluteLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/8.
//

import AsyncDisplayKit
import TextureSwiftSupport

class AbsoluteLayoutController: BaseNodeController {

    var type: LayoutsSectionType = .original

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension AbsoluteLayoutController {
    private func configBackgroundNode() {
        let contentNode = AbsoluteContentNode()
        contentNode.type = type
        node.addSubnode(contentNode)

        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 100, left: 20, bottom: 100, right: 20), child: contentNode)
        }
    }
}

// MARK: - AbsoluteContentNode
class AbsoluteContentNode: ASDisplayNode {

    var type: LayoutsSectionType = .original

    private let guitarVideoNode = ColorNode(.black)
    private let nicCageVideoNode = ColorNode(.red)
    private let simonVideoNode = ColorNode(.blue)
    private let hlsVideoNode = ColorNode(.gray)

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let maxConstrainedSize = constrainedSize.max

        let width = maxConstrainedSize.width / 2.0
        let height = maxConstrainedSize.height / 3.0

        guitarVideoNode.style.layoutPosition = CGPoint.zero
        guitarVideoNode.style.preferredSize = CGSize(width: maxConstrainedSize.width, height: height)

        nicCageVideoNode.style.layoutPosition = CGPoint(x: width, y: height)
        nicCageVideoNode.style.preferredSize = CGSize(width: width, height: height)

        simonVideoNode.style.layoutPosition = CGPoint(x: 0.0, y: maxConstrainedSize.height - (height))
        simonVideoNode.style.preferredSize = CGSize(width: width, height: height)

        hlsVideoNode.style.layoutPosition = CGPoint(x: 0.0, y: height)
        hlsVideoNode.style.preferredSize = CGSize(width: width, height: height)

        return ASAbsoluteLayoutSpec(children: [guitarVideoNode, nicCageVideoNode, simonVideoNode, hlsVideoNode])
    }
}
