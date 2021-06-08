//
//  NormalNodeCell.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/8.
//

import AsyncDisplayKit

class NormalNodeCell: ASCellNode {
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.style.alignSelf = .center
        return node
    }()
    
    override init() {
        super.init()
        accessoryType = .disclosureIndicator
        automaticallyManagesSubnodes = true
    }
    
    func configItem(_ item: NormalListModel) {
        guard let title = item.title else {
            return
        }
        titleNode.attributedText = NSAttributedString(string: title,
                                                      attributes: attributes())
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nodeStack = ASStackLayoutSpec.horizontal()
        nodeStack.alignItems = .center
        nodeStack.child = titleNode
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15),
                                 child: nodeStack)
    }
    
    private func attributes() -> [NSAttributedString.Key: Any] {
        [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    }
}
