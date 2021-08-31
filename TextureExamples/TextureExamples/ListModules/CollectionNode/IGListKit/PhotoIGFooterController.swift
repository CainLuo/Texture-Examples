//
//  PhotoIGFooterController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/8/31.
//

import RxSwift
import RxCocoa
import IGListKit
import AsyncDisplayKit
import TextureSwiftSupport

class PhotoIGFooterController: ListSectionController, ASSectionController {
}

// MARK: IGListKit override methods
extension PhotoIGFooterController {
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
extension PhotoIGFooterController {
    override func numberOfItems() -> Int {
        1
    }
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        { PhotoIGOtherCellNode("PhotoIG_Footer".localized()) }
    }
}
