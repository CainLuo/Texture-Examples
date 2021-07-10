//
//  ButtonNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit
import TextureSwiftSupport

class ButtonNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension ButtonNodeController {
    private func configBackgroundNode() {
        let contentNode = ButtonContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: contentNode)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: centerSpec)
        }
    }
}

// MARK: - ButtonContentNode
class ButtonContentNode: ASDisplayNode {

    private let buttonNode1 = ASButtonNode()
    private let buttonNode2 = ASButtonNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        configButtonNodes()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            VStackLayout(spacing: 10) {
                buttonNode1
                buttonNode2
            }
        }
    }
    
    private func configButtonNodes() {
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
        buttonNode1.style.minSize = CGSize(width: 100, height: 50)
        buttonNode1.setBackgroundImage(normalImage, for: .normal)
        buttonNode1.setBackgroundImage(lightImage, for: .highlighted)
        buttonNode1.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
        buttonNode1.setTitle("InfoNode_Reset".localized(), with: nil, with: .white, for: .normal)

        buttonNode2.style.minSize = CGSize(width: 100, height: 50)
        buttonNode2.style.flexBasis = ASDimensionMake("50%")
        buttonNode2.setBackgroundImage(normalImage, for: .normal)
        buttonNode2.setBackgroundImage(lightImage, for: .highlighted)
        buttonNode2.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
        buttonNode2.setTitle("InfoNode_Start".localized(), with: nil, with: .white, for: .normal)
    }
    
    @objc func buttonAction(_ sender: ASButtonNode) {
        log.debug("Button Node: \(sender)")
    }
}
