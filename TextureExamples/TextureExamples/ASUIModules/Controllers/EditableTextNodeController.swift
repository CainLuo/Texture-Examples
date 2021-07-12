//
//  EditableTextNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/12.
//

import AsyncDisplayKit
import TextureSwiftSupport

class EditableTextNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension EditableTextNodeController {
    private func configBackgroundNode() {
        let contentNode = EditableTextContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: .infinity, right: 10), child: contentNode)
        }
    }
}

// MARK: - EditableTextContentNode
class EditableTextContentNode: ASDisplayNode {

    let editableText = ASEditableTextNode()
    let editableText2 = ASEditableTextNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        editableText.delegate = self
        editableText.attributedPlaceholderText = NSAttributedString.attributed("This is placeholder")
        editableText.backgroundColor = .lightGray
        editableText.style.flexBasis = ASDimensionMake("50%")

        editableText2.delegate = self
        editableText2.attributedPlaceholderText = NSAttributedString.attributed("This is placeholder", color: .black)
        editableText2.textView.font = UIFont.systemFont(ofSize: 16)
        editableText2.backgroundColor = .cyan
        editableText2.style.flexBasis = ASDimensionMake("50%")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            VStackLayout(spacing: 10) {
                editableText
                editableText2
            }
            .preferredSize(CGSize(width: constrainedSize.max.width, height: 300))
        }
    }
}

// MARK: - ASEditableTextNodeDelegate
extension EditableTextContentNode: ASEditableTextNodeDelegate {
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
        log.debug("Did finish editing")
    }
}
