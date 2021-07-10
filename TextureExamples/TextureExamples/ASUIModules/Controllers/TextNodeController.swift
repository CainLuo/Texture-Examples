//
//  TextNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit
import TextureSwiftSupport

class TextNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension TextNodeController {
    private func configBackgroundNode() {
        let contentNode = TextContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: contentNode)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: centerSpec)
        }
    }
}

// MARK: - TextContentNode
class TextContentNode: ASDisplayNode {

    let titleNode = ASTextNode()
    let descriptionNode = ASTextNode()
    let contentNode1 = ASTextNode()
    let contentNode2 = ASTextNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        titleNode.backgroundColor = .cyan
        descriptionNode.backgroundColor = .cyan
        contentNode1.backgroundColor = .cyan
        contentNode2.backgroundColor = .cyan
        titleNode.attributedText = NSAttributedString.attributed("TextNode_Title".localized(), fontSize: 16)
        descriptionNode.attributedText = NSAttributedString.attributed("TextNode_Description".localized(), fontSize: 12)
        contentNode1.attributedText = NSAttributedString.attributed("TextNode_Content1".localized(), fontSize: 14)
        contentNode2.attributedText = NSAttributedString.attributed("TextNode_Content2".localized(), fontSize: 14)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        contentNode1.style.flexShrink = 1.0
        contentNode2.style.flexShrink = 1.0
        
        contentNode1.style.flexBasis = ASDimensionMake("50%")
        contentNode2.style.flexBasis = ASDimensionMake("50%")

        return LayoutSpec {
            VStackLayout(spacing: 10) {
                CenterLayout(centeringOptions: .X) {
                    titleNode
                }
                CenterLayout(centeringOptions: .X) {
                    descriptionNode
                }
                HStackLayout(spacing: 10) {
                    contentNode1
                    contentNode2
                }
            }
        }
    }
}
