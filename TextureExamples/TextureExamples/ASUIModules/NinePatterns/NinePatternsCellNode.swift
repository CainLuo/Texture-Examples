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
    private var images: [String] = []
    private let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    init(_ item: NinePatternsModel) {
        super.init()
        images = item.image
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
            InsetLayout(insets: insets) {
                VStackLayout(spacing: 10) {
                    HStackLayout(spacing: 10, alignItems: .center) {
                        avatarImageNode
                        nameNode
                    }
                    configNicePatternsNodes(constrainedSize.max)
                }
            }
        }
    }

    /// Config Nice Image Layout Spec
    /// - Parameter size: CGSize, Node constrainedSize max size
    /// - Returns: ASLayoutSpec
    private func configNicePatternsNodes(_ size: CGSize) -> ASLayoutSpec {
        var nodes: [ASDisplayNode] = []

        let colCount = 3
        let margin: CGFloat = 4
        let width = (size.width - CGFloat(colCount - 1) * margin - (insets.left * 2)) / CGFloat(colCount)

        for index in 0..<images.count {
            let row = index / colCount
            let col = index % colCount
            let pointX = CGFloat(col) * (width + margin)
            let pointY = CGFloat(row) * (width + margin)

            let node = ASNetworkImageNode()
            node.setURL(URL(string: images[index]), resetToDefault: true)
            node.style.preferredSize = CGSize(width: width, height: width)
            node.style.layoutPosition = CGPoint(x: pointX, y: pointY)
            nodes.append(node)
        }

        return  LayoutSpec {
            AbsoluteLayout {
                nodes
            }
        }
    }
}
