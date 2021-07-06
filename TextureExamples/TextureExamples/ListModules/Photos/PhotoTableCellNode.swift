//
//  PhotoTableCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import AsyncDisplayKit

class PhotoTableCellNode: ASCellNode {

    // MARK: Properties

    let usernameLabel = ASTextNode()
    let timeIntervalLabel = ASTextNode()
    let photoLikesLabel = ASTextNode()
    let photoDescriptionLabel = ASTextNode()

    let avatarImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        // Set the imageModificationBlock for a rounded avatar
        node.imageModificationBlock = ASImageNodeRoundBorderModificationBlock(0, nil)
        return node
    }()

    let photoImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()

    // MARK: Lifecycle
    init(_ model: PhotoTableModel) {
        super.init()
        automaticallyManagesSubnodes = true
        photoImageNode.url = URL(string: model.urls?.regular ?? "")
        avatarImageNode.url = URL(string: model.user?.profileImage?.medium ?? "")
        usernameLabel.attributedText = model.attributedStringForUserName(withSize: Constants.CellLayout.FontSize)
        timeIntervalLabel.attributedText = model.attributedStringForTimeSinceString(withSize: Constants.CellLayout.FontSize)
        photoLikesLabel.attributedText = model.attributedStringLikes(withSize: Constants.CellLayout.FontSize)
        photoDescriptionLabel.attributedText = model.attributedStringForDescription(withSize: Constants.CellLayout.FontSize)
    }

    // MARK: ASDisplayNode
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        // Header Stack
        var headerChildren: [ASLayoutElement] = []

        let headerStack = ASStackLayoutSpec.horizontal()
        headerStack.alignItems = .center
        avatarImageNode.style.preferredSize = CGSize(
            width: Constants.CellLayout.UserImageHeight,
            height: Constants.CellLayout.UserImageHeight
        )
        headerChildren.append(ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForAvatar, child: avatarImageNode))

        usernameLabel.style.flexShrink = 1.0
        headerChildren.append(usernameLabel)

        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        headerChildren.append(spacer)

        timeIntervalLabel.style.spacingBefore = Constants.CellLayout.HorizontalBuffer
        headerChildren.append(timeIntervalLabel)

        let footerStack = ASStackLayoutSpec.vertical()
        footerStack.spacing = Constants.CellLayout.VerticalBuffer
        footerStack.children = [photoLikesLabel, photoDescriptionLabel]
        headerStack.children = headerChildren

        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [
            ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForHeader, child: headerStack),
            ASRatioLayoutSpec(ratio: 1.0, child: photoImageNode),
            ASInsetLayoutSpec(insets: Constants.CellLayout.InsetForFooter, child: footerStack)
        ]
        return verticalStack
    }
}
