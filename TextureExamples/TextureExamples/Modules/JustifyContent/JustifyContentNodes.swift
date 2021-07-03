//
//  JustifyContentNodes.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/1.
//

import AsyncDisplayKit

// MARK: - JustifyContentRoundNode
class JustifyContentRoundNode: ASDisplayNode {
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .yellow
    }
}

// MARK: - JustifyContentSquareNode
class JustifyContentSquareNode: ASDisplayNode {
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .green
    }
}
