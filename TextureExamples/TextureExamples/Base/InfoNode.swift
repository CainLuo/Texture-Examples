//
//  InfoNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/2.
//

import AsyncDisplayKit

protocol InfoNodeDelegate: AnyObject {
    func infoNodeDidSelectDefine(_ node: InfoNode)
}

class InfoNode: ASDisplayNode {
    private let buttonNode = ASButtonNode()
    private let textNode = ASTextNode()

}
