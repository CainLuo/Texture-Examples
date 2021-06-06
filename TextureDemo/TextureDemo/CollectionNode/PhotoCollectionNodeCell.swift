//
//  PhotoCollectionNodeCell.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import AsyncDisplayKit
import TextureSwiftSupport

class PhotoCollectionNodeCell: ASCellNode {
    
    var index: Int = 0
    
    lazy var textNode: ASTextNode = {
        let textNode = ASTextNode()
        let text = "这是什么鬼: \(index)"
        textNode.attributedText = NSAttributedString(string: text,
                                                     attributes: attributes())
        return textNode
    }()
    lazy var contentNode: ASTextNode = {
        let contentNode = ASTextNode()
        let content = "这是内容: \(index)"
        contentNode.attributedText = NSAttributedString(string: content,
                                                     attributes: attributes())
        return contentNode
    }()
    lazy var otherNode: ASTextNode = {
        let contentNode = ASTextNode()
        let content = "其他标签: \(index)"
        contentNode.attributedText = NSAttributedString(string: content,
                                                     attributes: attributes())
        return contentNode
    }()

    init(_ index: Int) {
        super.init()
        self.index = index
        automaticallyManagesSubnodes = true
    }
    
    // 布局样式一
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        let center = ASCenterLayoutSpec()
//        center.centeringOptions = .XY
//        if let textNode = textNode {
//            center.child = textNode
//        }
//        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15),
//                                 child: center)
//    }
    
    // 布局样式二
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        var leftChildren: [ASLayoutElement] = []
//
//        let leftStack = ASStackLayoutSpec.vertical()
//        leftStack.alignItems = .center
//
//        textNode.style.flexShrink = 1.0
//        leftChildren.append(textNode)
//        leftChildren.append(contentNode)
//
//        leftStack.children = leftChildren
//
//        let nodeStack = ASStackLayoutSpec.horizontal()
//        nodeStack.alignItems = .center
//
//        otherNode.style.flexShrink = 1.0
//
//        nodeStack.children = [
//            ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForHeader,
//                              child: leftStack),
//            ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForFooter,
//                              child: otherNode)
//        ]
//
//        return nodeStack
//    }
    
    // TextureSwiftSupport布局样式
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
      LayoutSpec {
        HStackLayout {
            VStackLayout {
              self.textNode
              self.contentNode
            }.padding(5)

            self.otherNode//.padding(.all, 5)
        }
        .padding(.all, 5)
      }
    }
    
    private func attributes() -> [NSAttributedString.Key: Any] {
        [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
