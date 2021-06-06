//
//  PhotoListNodeCell.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import AsyncDisplayKit

class PhotoListNodeCell: ASCellNode {
    
    // MARK: - 控件属性
    let usernameLabel = ASTextNode()
    let photoImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()

    // MARK: - 生命周期
    init(photoModel: PhotoModel) {
        super.init()
        
        automaticallyManagesSubnodes = true
        usernameLabel.attributedText = photoModel.attributedStringForUserName(withSize: Constants.CellLayout.FontSize)
        photoImageNode.url = URL(string: photoModel.url)
        usernameLabel.attributedText = photoModel.attributedStringForUserName(withSize: Constants.CellLayout.FontSize)
    }
    
    // MARK: - 布局代码
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Header Stack
        
        var headerChildren: [ASLayoutElement] = []
        
        let headerStack = ASStackLayoutSpec.horizontal()
        headerStack.alignItems = .center
        
        usernameLabel.style.flexShrink = 1.0
        headerChildren.append(usernameLabel)
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        headerChildren.append(spacer)
                
        let footerStack = ASStackLayoutSpec.vertical()
        footerStack.spacing = Constants.CellLayout.VerticalBuffer
        headerStack.children = headerChildren
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [
            ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForHeader,
                              child: headerStack),
            ASRatioLayoutSpec(ratio: 1.0,
                              child: photoImageNode),
            ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForFooter,
                              child: footerStack)
        ]
        return verticalStack
    }
}
