//
//  JustifyContentController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/30.
//

import AsyncDisplayKit

class JustifyContentController: ASDKViewController<ASDisplayNode> {
    
    private let roundNode = JustifyContentRoundNode()
    
    init(_ type: ASStackLayoutJustifyContent) {
        super.init(node: ASDisplayNode())
        
        configBackgroundNode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
}

extension JustifyContentController {
    private func configBackgroundNode() {
        
        node.addSubnode(roundNode)
        
        node.layoutSpecBlock = { [weak self] node, constrainedSize in
            guard let roundNode = self?.roundNode else { return ASLayoutSpec() }
            
            roundNode.style.preferredSize = CGSize(width: 100, height: 100)
            
            let stack = ASStackLayoutSpec.horizontal()
            stack.child = roundNode
            stack.justifyContent = .end
            
            return stack
        }
    }
}
