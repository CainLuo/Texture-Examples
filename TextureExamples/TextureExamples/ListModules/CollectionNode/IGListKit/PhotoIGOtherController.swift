//
//  PhotoIGOtherController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/8/30.
//

import RxSwift
import RxCocoa
import IGListKit
import AsyncDisplayKit
import TextureSwiftSupport

class PhotoIGOtherController: ListSectionController, ASSectionController {
}

// MARK: IGListKit override methods
extension PhotoIGOtherController {
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = ASIGListSectionControllerMethods.sizeForItem(at: index)
        return size
    }
    
    override func didUpdate(to object: Any) {
    }
    
    override func didSelectItem(at index: Int) {
        log.debug(index)
    }
}

// MARK: - Data Source Method
extension PhotoIGOtherController {
    override func numberOfItems() -> Int {
        1
    }
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        { PhotoIGOtherCellNode() }
    }
}

class PhotoIGOtherCellNode: ASCellNode {
    private var titleNode = ASTextNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        titleNode.attributedText = NSAttributedString.attributed("这是一条其他的CellNode")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                titleNode
                    .height(40)
            }
        }
    }
}
