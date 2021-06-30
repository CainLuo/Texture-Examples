//
//  JustifyContentController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/30.
//

import AsyncDisplayKit

class JustifyContentController: ASDKViewController<ASDisplayNode> {
    
    init(_ type: ASStackLayoutJustifyContent) {
        super.init(node: ASDisplayNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
}
