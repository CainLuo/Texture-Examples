//
//  ImageNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit
import TextureSwiftSupport

class ImageNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.backgroundColor = .gray
        node.setNeedsLayout()
    }
}

extension ImageNodeController {
    private func configBackgroundNode() {
        let contentNode = ImageContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: contentNode)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: centerSpec)
        }
    }
}

// MARK: - ImageContentNode
class ImageContentNode: ASDisplayNode {

    let imageNode1 = ASImageNode()

    let imageNode2: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        imageNode1.image = #imageLiteral(resourceName: "image1")
        imageNode2.image = #imageLiteral(resourceName: "image2")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            VStackLayout(spacing: 10) {
                CenterLayout(centeringOptions: .X) {
                    imageNode1
                }
                CenterLayout(centeringOptions: .X) {
                    imageNode2
                }
            }
        }
    }
}
