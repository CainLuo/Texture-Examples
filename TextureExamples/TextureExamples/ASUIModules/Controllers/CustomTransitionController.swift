//
//  CustomTransitionController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/26.
//

import AsyncDisplayKit
import TextureSwiftSupport

class CustomTransitionController: BaseNodeController {

    private let transitionNode = CustomTransitionNode()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubnode(transitionNode)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = transitionNode.layoutThatFits(ASSizeRange(min: .zero, max: view.frame.size)).size
        transitionNode.frame = CGRect(x: 0, y: 20, width: size.width, height: size.height)
    }
}

class CustomTransitionNode: ASDisplayNode {
    private var isEnabled = false

    private lazy var contentNode1: ASImageNode = {
        let node = ASImageNode()
        node.style.flexGrow = 1.0
        node.style.flexShrink = 1.0
        node.image = #imageLiteral(resourceName: "image1")
        return node
    }()

    private lazy var contentNode2: ASImageNode = {
        let node = ASImageNode()
        node.style.flexGrow = 1.0
        node.style.flexShrink = 1.0
        node.image = #imageLiteral(resourceName: "image2")
        return node
    }()

    private lazy var transitionButton: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .black
        node.setAttributedTitle(NSAttributedString.attributed("Transition", color: .white), for: .normal)
        node.style.alignSelf = .center
        node.addTarget(self, action: #selector(nodeTransition), forControlEvents: .touchUpInside)
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        defaultLayoutTransitionDuration = 1.0
    }

    @objc func nodeTransition(_ node: ASButtonNode) {
        isEnabled = !isEnabled
        transitionLayout(withAnimation: true, shouldMeasureAsync: false, measurementCompletion: nil)
    }

    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        guard let fromNode = context.removedSubnodes().first,
              let toNode = context.insertedSubnodes().first else {
            return
        }

        var buttonNode: ASButtonNode!
        for node in context.subnodes(forKey: ASTransitionContextToLayoutKey) {
            if let subNode = node as? ASButtonNode {
                buttonNode = subNode
            }
        }

        var toNodeFrame = context.finalFrame(for: toNode)
        toNodeFrame.origin.x += isEnabled ? toNodeFrame.size.width : -toNodeFrame.size.width
        toNode.frame = toNodeFrame
        toNode.alpha = 0.0

        var fromNodeFrame = fromNode.frame
        fromNodeFrame.origin.x += isEnabled ? -fromNodeFrame.size.width : fromNodeFrame.size.width

        UIView.animate(withDuration: defaultLayoutTransitionDuration) {
            toNode.frame = context.finalFrame(for: toNode)
            toNode.alpha = 1.0

            fromNode.frame = fromNodeFrame
            fromNode.alpha = 0.0

            if let fromSize = context.layout(forKey: ASTransitionContextFromLayoutKey)?.size,
               let toSize = context.layout(forKey: ASTransitionContextToLayoutKey)?.size {
                let isResized = __CGSizeEqualToSize(fromSize, toSize)
                if isResized {
                    let position = self.frame.origin
                    self.frame = CGRect(x: position.x, y: position.y, width: toSize.width, height: toSize.height)
                }
            }

            buttonNode.frame = context.finalFrame(for: buttonNode)
        } completion: { finished in
            context.completeTransition(finished)
        }
    }
}

extension CustomTransitionNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            InsetLayout(insets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)) {
                VStackLayout(spacing: 15) {
                    HStackLayout {
                        if isEnabled {
                            contentNode2
                        } else {
                            contentNode1
                        }
                    }
                    transitionButton
                        .height(44)
                }
            }
        }
    }
}
