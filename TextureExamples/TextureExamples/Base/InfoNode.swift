//
//  InfoNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/2.
//

import AsyncDisplayKit

protocol InfoNodeDelegate: AnyObject {
    func infoNodeDidSelectDefine(_ node: InfoNode, isReset: Bool)
}

class InfoNode: ASDisplayNode {
    private lazy var resetNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .purple
        node.setTitle("InfoNode_Reset".localized(), with: UIFont.systemFont(ofSize: 16), with: .white, for: .normal)
        node.addTarget(self, action: #selector(resetAction), forControlEvents: .touchUpInside)
        return node
    }()
    private lazy var startNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .blue
        node.addTarget(self, action: #selector(startAction), forControlEvents: .touchUpInside)
        node.setTitle("InfoNode_Start".localized(), with: UIFont.systemFont(ofSize: 16), with: .white, for: .normal)
        return node
    }()
    private let textNode = ASTextNode()
    
    weak var delegate: InfoNodeDelegate?
    
    init(_ content: String) {
        super.init()
        automaticallyManagesSubnodes = true
        textNode.attributedText = NSAttributedString.attributed(content)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        textNode.style.flexGrow = 1.0
        textNode.style.flexShrink = 1.0
        
        resetNode.style.flexBasis = ASDimensionMake("50%")
        startNode.style.flexBasis = ASDimensionMake("50%")

        let hStack = ASStackLayoutSpec.horizontal()
        hStack.children = [resetNode, startNode]
        hStack.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 44)
        hStack.style.spacingBefore = 10

        let stack = ASStackLayoutSpec.vertical()
        stack.children = [textNode, hStack]
        return stack
    }
}

// MARK: - Actions
extension InfoNode {
    @objc func resetAction(_ sender: Any) {
        delegate?.infoNodeDidSelectDefine(self, isReset: true)
    }

    @objc func startAction(_ sender: Any) {
        delegate?.infoNodeDidSelectDefine(self, isReset: false)
    }
}
