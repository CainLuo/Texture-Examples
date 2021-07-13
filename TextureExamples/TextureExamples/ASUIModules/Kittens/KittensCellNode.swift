//
//  KittensCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/13.
//

import AsyncDisplayKit
import TextureSwiftSupport

class KittensCellNode: ASCellNode {

    let imageNode = ASNetworkImageNode()
    let imageSize = 80.0

    let textNode = ASTextNode()

    let lineNode = ASDisplayNode()

    var swappedTextAndImage = false
    var isImageEnlarged = false

    init(_ size: CGSize) {
        super.init()
        automaticallyManagesSubnodes = true

        lineNode.backgroundColor = .lightGray
        addSubnode(lineNode)

        textNode.shadowColor = UIColor.black.cgColor
        textNode.shadowRadius = 3
        textNode.shadowOffset = CGSize(width: -2, height: -2)
        textNode.shadowOpacity = 0.3
        textNode.maximumNumberOfLines = 2
        textNode.truncationAttributedText = NSAttributedString(string: "...")
        textNode.additionalTruncationMessage = NSAttributedString(string: "More")
        textNode.attributedText = NSAttributedString.attributed("Kitty ipsum dolor sit amet, purr sleep on your face lay down in your way biting, sniff tincidunt a etiam fluffy fur judging you stuck in a tree kittens.")
        textNode.style.flexShrink = 1.0

        imageNode.url = URL(string: "https://placekitten.com/\(Int(size.width))/\(Int(size.height))")
        imageNode.addTarget(self, action: #selector(toggleNodesSwap), forControlEvents: .touchUpInside)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: isImageEnlarged ? 2.0 * imageSize : imageSize,
                                               height: isImageEnlarged ? 2.0 * imageSize : imageSize)
        return LayoutSpec {
            InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                HStackLayout(spacing: 10, justifyContent: .start, alignItems: .start) {
                    if swappedTextAndImage {
                        textNode
                        imageNode
                    } else {
                        imageNode
                        textNode
                    }
                }
            }
        }
    }

    override func layout() {
        super.layout()
        let pixelHeight = 1.0 / UIScreen.main.scale
        lineNode.frame = CGRect(x: 15, y: 0, width: calculatedSize.width, height: pixelHeight)
    }

    func toggleImageEnlargement() {
        isImageEnlarged = !isImageEnlarged
        setNeedsLayout()
    }

    @objc private func toggleNodesSwap() {
        swappedTextAndImage = !swappedTextAndImage
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] _ in
            self?.setNeedsLayout()
            self?.layoutIfNeeded()
            UIView.animate(withDuration: 0.15) {
                self?.alpha = 1
            }
        }
    }
}
