//
//  AlignItemsController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/30.
//

import AsyncDisplayKit

class AlignItemsController: ASDKViewController<ASDisplayNode> {
    
    private let roundNode = RoundNode()
    private let squareNode = SquareNode()
    private lazy var infoNode: InfoNode = {
        let node = InfoNode("AlignItems_\(alignItemsType.rawValue)".localized())
        node.delegate = self
        return node
    }()
    private var isShowAnimated = false
    private var alignItemsType: ASStackLayoutAlignItems = .start

    init(_ type: ASStackLayoutAlignItems) {
        super.init(node: ASDisplayNode())
        node.automaticallyRelayoutOnSafeAreaChanges = true
        alignItemsType = type
        configBackgroundNode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
}

extension AlignItemsController {
    private func configBackgroundNode() {

        node.addSubnode(roundNode)
        node.addSubnode(squareNode)
        node.addSubnode(infoNode)

        node.layoutSpecBlock = { [weak self] node, constrainedSize in
            guard let roundNode = self?.roundNode,
                  let squareNode = self?.squareNode,
                  let infoNode = self?.infoNode else {
                return ASLayoutSpec()
            }
            
            squareNode.style.preferredSize = CGSize(width: 100, height: 100)
            squareNode.cornerRadius = 50
            roundNode.style.preferredSize = CGSize(width: 100, height: 100)

            let hStack = ASStackLayoutSpec.horizontal()
            hStack.children = [roundNode, squareNode]
            hStack.alignItems = self?.foregroundAlignItemsType() ?? .start
            hStack.style.flexBasis = ASDimensionMake("50%")
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.children = [hStack, infoNode]
            vStack.justifyContent = .spaceBetween
            return ASInsetLayoutSpec(insets: node.safeAreaInsets, child: vStack)
        }
    }
}

// MARK: - InfoNodeDelegate
extension AlignItemsController: InfoNodeDelegate {
    func infoNodeDidSelectDefine(_ node: InfoNode, isReset: Bool) {
        isShowAnimated = !isReset
        self.node.setNeedsLayout()
    }
}

// MARK: ASStackLayoutJustifyContent Methods
extension AlignItemsController {
    func foregroundAlignItemsType() -> ASStackLayoutAlignItems {
        switch alignItemsType {
        case .start, .baselineFirst, .baselineLast:
            return !isShowAnimated ? .end : alignItemsType
        default:
            return !isShowAnimated ? .start : alignItemsType
        }
    }
}
