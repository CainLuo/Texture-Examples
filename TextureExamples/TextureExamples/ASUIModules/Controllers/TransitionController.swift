//
//  TransitionController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/26.
//

import AsyncDisplayKit
import TextureSwiftSupport

class TransitionController: BaseNodeController {

    private let transitionNode = TransitionNode()

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

class TransitionNode: ASDisplayNode {
    private var isEnabled = false
    private lazy var contentNode1: ASTextNode = {
        let node = ASTextNode()
        node.style.flexGrow = 1.0
        node.style.flexShrink = 1.0
        node.backgroundColor = .blue
        node.attributedText = NSAttributedString(string: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled")
        return node
    }()

    private lazy var contentNode2: ASTextNode = {
        let node = ASTextNode()
        node.style.flexGrow = 1.0
        node.style.flexShrink = 1.0
        node.backgroundColor = .gray
        node.attributedText = NSAttributedString(string: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.")
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
}

extension TransitionNode {
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
