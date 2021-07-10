//
//  MapNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit
import TextureSwiftSupport

class MapNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension MapNodeController {
    private func configBackgroundNode() {
        let contentNode = MapContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: node.safeAreaInsets, child: contentNode)
        }
    }
}

// MARK: - MapContentNode
class MapContentNode: ASDisplayNode {

    let mapNode = ASMapNode()
    let updateNode = ASButtonNode()
    let toggleNode = ASButtonNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        configButtonNodes()
        mapNode.style.flexGrow = 1.0
        mapNode.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 21, longitude: 101),
                                            span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            VStackLayout(spacing: 10) {
                mapNode
                HStackLayout {
                    updateNode
                    toggleNode
                }
                .preferredSize(CGSize(width: constrainedSize.max.width, height: 44))
            }
        }
    }
    
    override func didLoad() {
        super.didLoad()
        mapNode.isLiveMap = true
    }
    
    private func configButtonNodes() {
        mapNode.style.flexGrow = 1.0
        let normalImage = UIImage.as_resizableRoundedImage(withCornerRadius: 5,
                                                           cornerColor: .white,
                                                           fill: .gray,
                                                           traitCollection: primitiveTraitCollection())
        let lightImage = UIImage.as_resizableRoundedImage(withCornerRadius: 5,
                                                          cornerColor: .white,
                                                          fill: .red,
                                                          borderColor: .blue,
                                                          borderWidth: 1.0,
                                                          traitCollection: primitiveTraitCollection())
        updateNode.style.flexBasis = ASDimensionMake("50%")
        updateNode.setBackgroundImage(normalImage, for: .normal)
        updateNode.setBackgroundImage(lightImage, for: .highlighted)
        updateNode.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
        updateNode.setTitle("InfoNode_Reset".localized(), with: nil, with: .white, for: .normal)

        toggleNode.style.flexBasis = ASDimensionMake("50%")
        toggleNode.setBackgroundImage(normalImage, for: .normal)
        toggleNode.setBackgroundImage(lightImage, for: .highlighted)
        toggleNode.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
        toggleNode.setTitle("InfoNode_Start".localized(), with: nil, with: .white, for: .normal)
    }
    
    @objc func buttonAction(_ sender: ASButtonNode) {
        log.debug("Button Node: \(sender)")
    }
}
