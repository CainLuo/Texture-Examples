//
//  JustifyContentNodes.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/1.
//

import AsyncDisplayKit

class JustifyContentRoundNode: ASDisplayNode {
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .yellow
    }
}

class JustifyContentSquareNode: ASDisplayNode {
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .green
    }
}
