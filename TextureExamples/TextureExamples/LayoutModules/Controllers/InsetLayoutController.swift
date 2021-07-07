//
//  InsetLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import UIKit
import AsyncDisplayKit

class InsetLayoutController: BaseNodeController {

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

extension InsetLayoutController {
    private func configBackgroundNode() {
        node.addSubnode(imageNode)
        node.layoutSpecBlock = { [weak self] node, constrainedSize in
            guard let imageNode = self?.imageNode else {
                return ASLayoutSpec()
            }

            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: .infinity, right: 10),
                                     child: imageNode)
        }
    }
}
