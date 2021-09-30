//
//  PhotoIGHeaderController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/8/30.
//

import RxSwift
import RxCocoa
import IGListKit
import AsyncDisplayKit
import TextureSwiftSupport

class PhotoIGHeaderController: ListSectionController, ASSectionController {
}

// MARK: IGListKit override methods
extension PhotoIGHeaderController {
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    override func didUpdate(to object: Any) {
    }
    
    override func didSelectItem(at index: Int) {
        log.debug(index)
    }
}

// MARK: - Data Source Method
extension PhotoIGHeaderController {
    override func numberOfItems() -> Int {
        1
    }
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        { PhotoIGOtherCellNode("PhotoIG_Header".localized()) }
    }
}
