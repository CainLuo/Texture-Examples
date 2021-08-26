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
    
    private let disposeBag = DisposeBag()
    private var photoSection: PhotoIGSectionsModel!
    private let viewModel: PhotoTableViewModelTypes = PhotoTableViewModel()
    private var batchContext: ASBatchContext?

    override init() {
        super.init()
        
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                self?.reloadDataSource(items)
            })
            .disposed(by: disposeBag)
    }
    
    private func reloadDataSource(_ items: [PhotoTableModel]) {
        if !items.isEmpty,
           let context = collectionContext {
            
            let tempItems = photoSection.photos + items
            
            context.performBatch(animated: true) { [weak self] context in
                guard let weakSelf = self else {
                    return
                }
                
                let resultIndexSet = ListDiff(oldArray: weakSelf.photoSection.photos, newArray: tempItems, option: .equality)
                context.insert(in: weakSelf, at: resultIndexSet.inserts)
                context.delete(in: weakSelf, at: resultIndexSet.deletes)
                weakSelf.photoSection.photos.append(contentsOf: items)
            }
            
            batchContext?.completeBatchFetching(true)
        }
    }
}

// MARK: Fetch Photos
extension PhotoIGController {
    func beginBatchFetch(with context: ASBatchContext) {
        batchContext = context
        viewModel.inputs.fetchList()
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
        if let section = object as? PhotoIGSectionsModel {
            photoSection = section
        }
    }
    
    override func didSelectItem(at index: Int) {
        log.debug(index)
    }
}

// MARK: - Data Source Method
extension PhotoIGController {
    override func numberOfItems() -> Int {
        photoSection.photos.count
    }
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        let item = photoSection.photos[index]
        return { PhotoTableCellNode(item) }
    }
}
