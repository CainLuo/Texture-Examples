//
//  AlignItemsController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/30.
//

import AsyncDisplayKit

class AlignItemsController: ASDKViewController<ASDisplayNode> {

    init(_ type: ASStackLayoutAlignItems) {
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
