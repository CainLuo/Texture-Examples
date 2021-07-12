//
//  ScrollNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/12.
//

import UIKit
import AsyncDisplayKit
import TextureSwiftSupport

class ScrollNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension ScrollNodeController {
    private func configBackgroundNode() {
        let contentNode = ScrollContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            ASWrapperLayoutSpec(layoutElement: contentNode)
        }
    }
}

// MARK: - ScrollContentNode
class ScrollContentNode: ASScrollNode {
    let imageNode = ASImageNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true

        imageNode.image = #imageLiteral(resourceName: "image2")
        imageNode.style.flexShrink = 1.0
        imageNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.height * 2,
                                               height: UIScreen .main.bounds.size.height * 2)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            WrapperLayout {
                imageNode
            }
        }
    }
}
