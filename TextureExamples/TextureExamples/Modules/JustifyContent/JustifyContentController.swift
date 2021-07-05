//
//  JustifyContentController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/30.
//

import AsyncDisplayKit

class JustifyContentController: ASDKViewController<ASDisplayNode> {
    
    private let roundNode = RoundNode()
    private let squareNode = SquareNode()
    private lazy var infoNode: InfoNode = {
        let node = InfoNode("JustifyContent_\(justifyContentType.rawValue)".localized())
        node.delegate = self
        return node
    }()
    private var isShowAnimated = false
    
    private var justifyContentType: ASStackLayoutJustifyContent = .start
    
    init(_ type: ASStackLayoutJustifyContent) {
        super.init(node: ASDisplayNode())
        node.automaticallyRelayoutOnSafeAreaChanges = true
        justifyContentType = type
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

extension JustifyContentController {
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
            hStack.justifyContent = self?.foregroundJustifyContentType() ?? .start
            hStack.children = [roundNode, squareNode]
            hStack.style.flexBasis = ASDimensionMake("50%")

            let vStack = ASStackLayoutSpec.vertical()
            vStack.children = [hStack, infoNode]
            vStack.justifyContent = .spaceBetween
            return ASInsetLayoutSpec(insets: node.safeAreaInsets, child: vStack)
        }
    }
}

// MARK: - InfoNodeDelegate
extension JustifyContentController: InfoNodeDelegate {
    func infoNodeDidSelectDefine(_ node: InfoNode, isReset: Bool) {
        isShowAnimated = !isReset
        self.node.setNeedsLayout()
    }
}

// MARK: ASStackLayoutJustifyContent Methods
extension JustifyContentController {
    func foregroundJustifyContentType() -> ASStackLayoutJustifyContent {
        switch justifyContentType {
        case .start:
            return !isShowAnimated ? .end : justifyContentType
        default:
            return !isShowAnimated ? .start : justifyContentType
        }
    }
}
