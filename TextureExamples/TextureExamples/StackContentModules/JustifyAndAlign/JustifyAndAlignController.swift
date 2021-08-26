//
//  AlignAndJustifyController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/5.
//

import AsyncDisplayKit

class AlignAndJustifyController: BaseNodeController {

    private let roundNode = RoundNode()
    private let squareNode = SquareNode()
    private lazy var infoNode: InfoNode = {
        let align = "ASStackLayoutAlignItems: \("AlignItems_\(alignItemsType.rawValue)".localized())\n"
        let justify = "ASStackLayoutJustifyContent : \("JustifyContent_\(justifyContentType.rawValue)".localized())"
        let node = InfoNode(align + justify)
        node.delegate = self
        return node
    }()
    private var isShowAnimated = false
    private var alignItemsType: ASStackLayoutAlignItems = .start
    private var justifyContentType: ASStackLayoutJustifyContent = .start

    init(_ align: ASStackLayoutAlignItems, justify: ASStackLayoutJustifyContent) {
        super.init()
        alignItemsType = align
        justifyContentType = justify
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

extension AlignAndJustifyController {
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
            hStack.justifyContent = self?.foregroundJustifyContentType() ?? .start
            hStack.style.flexBasis = ASDimensionMake("50%")

            let vStack = ASStackLayoutSpec.vertical()
            vStack.children = [hStack, infoNode]
            vStack.justifyContent = .spaceBetween
            return ASInsetLayoutSpec(insets: node.safeAreaInsets, child: vStack)
        }
    }
}

// MARK: - InfoNodeDelegate
extension AlignAndJustifyController: InfoNodeDelegate {
    func infoNodeDidSelectDefine(_ node: InfoNode, isReset: Bool) {
        isShowAnimated = !isReset
        self.node.setNeedsLayout()
    }
}

// MARK: ASStackLayoutJustifyContent Methods
extension AlignAndJustifyController {
    func foregroundAlignItemsType() -> ASStackLayoutAlignItems {
        switch alignItemsType {
        case .start, .baselineFirst, .baselineLast:
            return !isShowAnimated ? .end : alignItemsType
        default:
            return !isShowAnimated ? .start : alignItemsType
        }
    }
}

// MARK: ASStackLayoutJustifyContent Methods
extension AlignAndJustifyController {
    func foregroundJustifyContentType() -> ASStackLayoutJustifyContent {
        switch justifyContentType {
        case .start:
            return !isShowAnimated ? .end : justifyContentType
        default:
            return !isShowAnimated ? .start : justifyContentType
        }
    }
}
