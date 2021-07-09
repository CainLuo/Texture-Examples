//
//  NetworkImageNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit
import TextureSwiftSupport

class NetworkImageNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.backgroundColor = .gray
        node.setNeedsLayout()
    }
}

extension NetworkImageNodeController {
    private func configBackgroundNode() {
        let contentNode = NetworkImageContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: contentNode)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: centerSpec)
        }
    }
}

// MARK: - ImageContentNode
class NetworkImageContentNode: ASDisplayNode {

    let imageNode1 = ASNetworkImageNode()

    let imageNode2: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        node.defaultImage = #imageLiteral(resourceName: "image2")
        node.url = URL(string: "http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-photo.png")
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        imageNode1.defaultImage = #imageLiteral(resourceName: "image1")
        imageNode1.setURL(URL(string: "http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-photo.png"), resetToDefault: true)
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
