//
//  PhotoIGController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/8/24.
//

import RxSwift
import RxCocoa
import IGListKit
import AsyncDisplayKit

class PhotoIGController: ListSectionController, ASSectionController {
    private var photoModel: PhotoTableModel!
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        let item = photoModel!
        return { PhotoTableCellNode(item) }
    }
}

// MARK: IGListKit override methods
extension PhotoIGController {
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = ASIGListSectionControllerMethods.sizeForItem(at: index)
        return size
    }
    
    override func didUpdate(to object: Any) {
        photoModel = object as? PhotoTableModel
    }
}
