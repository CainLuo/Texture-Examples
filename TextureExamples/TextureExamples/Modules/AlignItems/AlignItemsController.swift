//
//  AlignItemsController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/30.
//

import AsyncDisplayKit

class AlignItemsController: ASDKViewController<ASDisplayNode> {
    
    private let roundNode = JustifyContentRoundNode()
    private let squareNode = JustifyContentSquareNode()
    private lazy var infoNode: InfoNode = {
        let node = InfoNode("JustifyContent_\(alignItemsType.rawValue)".localized())
        return node
    }()
    private var isShowAnimated = false
    private var alignItemsType: ASStackLayoutAlignItems = .start

    init(_ type: ASStackLayoutAlignItems) {
        super.init(node: ASDisplayNode())
        alignItemsType = type
        configBackgroundNode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
        infoNode.delegate = self
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

            infoNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 300)

            let squareStack = ASStackLayoutSpec.horizontal()
            squareStack.children = [roundNode, squareNode]
            squareStack.alignItems = self?.foregroundAlignItemsType() ?? .start
            squareStack.style.flexBasis = ASDimensionMake("50%")
            
            let roundStack = ASStackLayoutSpec.horizontal()
            roundStack.child = roundNode
            roundStack.alignItems = self?.alignItemsType ?? .start
            
            let vstack = ASStackLayoutSpec.vertical()
            vstack.children = [squareStack, infoNode]
            vstack.justifyContent = .spaceBetween
            return vstack
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
        case .start:
            return !isShowAnimated ? .end : alignItemsType
        default:
            return !isShowAnimated ? .start : alignItemsType
        }
    }
}
