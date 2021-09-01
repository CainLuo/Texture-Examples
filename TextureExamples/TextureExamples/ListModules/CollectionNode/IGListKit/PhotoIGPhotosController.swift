//
//  PhotoIGPhotosController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/8/24.
//

import RxSwift
import RxCocoa
import IGListKit
import AsyncDisplayKit

class PhotoIGPhotosController: ListSectionController {
    
    private let disposeBag = DisposeBag()
    private var photoSection: PhotoIGPhotoSectionModel!
    private let viewModel: PhotoTableViewModelTypes = PhotoTableViewModel()
    private var batchContext: ASBatchContext?

    override init() {
        super.init()
        
        supplementaryViewSource = self
        
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
extension PhotoIGPhotosController {
    func beginBatchFetch(with context: ASBatchContext) {
        batchContext = context
        viewModel.inputs.fetchList()
    }
}

// MARK: - Data Source Method
extension PhotoIGPhotosController {
    override func numberOfItems() -> Int {
        photoSection.photos.count
    }
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        let item = photoSection.photos[index]
        return { PhotoTableCellNode(item) }
    }
}

// MARK: - ListSupplementaryViewSource
extension PhotoIGPhotosController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        ASIGListSupplementaryViewSourceMethods.viewForSupplementaryElement(ofKind: elementKind, at: index, sectionController: self)
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        ASIGListSupplementaryViewSourceMethods.sizeForSupplementaryView(ofKind:elementKind, at:index)
    }
}

// MARK: ASSectionController
extension PhotoIGPhotosController: ASSectionController {
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    override func didUpdate(to object: Any) {
        photoSection = object as? PhotoIGPhotoSectionModel
    }
    
    override func didSelectItem(at index: Int) {
        log.debug(index)
    }
}

// MARK: - ASSupplementaryNodeSource
extension PhotoIGPhotosController: ASSupplementaryNodeSource {
    func nodeBlockForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASCellNodeBlock {
        {
            let cell = PhotoIGOtherCellNode("Section Header")
            cell.backgroundColor = .brown
            return cell
        }
    }
    
    func sizeRangeForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASSizeRange {
        ASSizeRange(min: CGSize(width: UIScreen.main.bounds.width, height: 80),
                    max: CGSize(width: UIScreen.main.bounds.width, height: 80))
    }
}
