//
//  WrapperLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import UIKit
import AsyncDisplayKit

class WrapperLayoutController: BaseNodeController {

    private lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "image1")
        node.backgroundColor = .gray
        return node
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        node.automaticallyRelayoutOnSafeAreaChanges = true
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension WrapperLayoutController {
    private func configBackgroundNode() {
        node.addSubnode(imageNode)
        node.layoutSpecBlock = { [weak self] node, constrainedSize in
            guard let imageNode = self?.imageNode else {
                return ASLayoutSpec()
            }
            imageNode.style.preferredSize = CGSize(width: constrainedSize.max.width,
                                                   height: constrainedSize.max.height / 2.0)
            return ASWrapperLayoutSpec(layoutElement: imageNode)
        }
    }
}
