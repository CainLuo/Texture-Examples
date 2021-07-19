//
//  NinePatternsCellNode.swift
//  NinePatternsCellNode
//
//  Created by CainLuo on 2021/7/20.
//

import RxCocoa
import RxSwift
import AsyncDisplayKit
import TextureSwiftSupport

class NinePatternsCellNode: ASCellNode {
    
    private let avatarImageNode = ASNetworkImageNode()
    private let nameNode = ASTextNode()
    
    init(_ item: NinePatternsModel) {
        super.init()
        automaticallyManagesSubnodes = true
        avatarImageNode.url = URL(string: item.avatar ?? "")
        avatarImageNode.style.preferredSize = CGSize(width: 40, height: 40)
        nameNode.attributedText = NSAttributedString.attributed(item.name ?? "")
        nameNode.style.flexGrow = 1.0
    }
}

extension NinePatternsCellNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                VStackLayout(spacing: 10) {
                    HStackLayout(spacing: 10, alignItems: .center) {
                        avatarImageNode
                        nameNode
                    }
                    configNicePatternsNodes()
                }
            }
        }
    }
    
    /// FIXME: Not Finish Logic
    private func configNicePatternsNodes() -> ASLayoutSpec {
        ASLayoutSpec()
    }
}
