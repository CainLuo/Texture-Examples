//
//  StackLayoutController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import UIKit
import AsyncDisplayKit

class StackLayoutController: BaseNodeController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
        node.backgroundColor = UIColor(0xf5f5f5)
    }
}

extension StackLayoutController {
    private func configBackgroundNode() {
        node.addSubnode(imageNode)
        node.addSubnode(imageNode1)
        node.layoutSpecBlock = { [weak self] node, constrainedSize in
            guard let imageNode = self?.imageNode,
                  let imageNode1 = self?.imageNode1 else {
                return ASLayoutSpec()
            }
            let hStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 6.0,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [imageNode, imageNode1])

            hStack.style.minWidth = ASDimensionMakeWithPoints(60.0)
            hStack.style.maxHeight = ASDimensionMakeWithPoints(40.0)

            return hStack
        }
    }
}
