//
//  JustifyContentController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/30.
//

import AsyncDisplayKit

class JustifyContentController: ASDKViewController<ASDisplayNode> {
    
    private let roundNode = JustifyContentRoundNode()
    private let squareNode = JustifyContentSquareNode()
    private let infoNode = InfoNode()
    private var isShowAnimated = false
    
    init(_ type: ASStackLayoutJustifyContent) {
        super.init(node: ASDisplayNode())
        configBackgroundNode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoNode.delegate = self
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

            infoNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 300)
            infoNode.style.spacingBefore = 100

            let squareStack = ASStackLayoutSpec.horizontal()
            squareStack.child = squareNode
            squareStack.justifyContent = self?.isShowAnimated == false ? .start : .end
            
            let roundStack = ASStackLayoutSpec.horizontal()
            roundStack.child = roundNode
            roundStack.justifyContent = .end
            
            let background = ASBackgroundLayoutSpec(child: squareStack, background: roundStack)

            let vstack = ASStackLayoutSpec.vertical()
            vstack.children = [background, infoNode]
            return vstack
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
