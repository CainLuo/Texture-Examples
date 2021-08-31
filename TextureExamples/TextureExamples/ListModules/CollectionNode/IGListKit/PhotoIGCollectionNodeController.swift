//
//  PhotoIGCollectionNodeController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/7.
//

import RxSwift
import RxCocoa
import IGListKit
import AsyncDisplayKit

class PhotoIGCollectionNodeController: ASDKViewController<ASCollectionNode> {
    
    private let sections = [PhotoIGHeaderSectionModel(),
                            PhotoIGPhotoSectionModel(),
                            PhotoIGFooterSectionModel()]
        
    lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    // Lifecycle
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(node: ASCollectionNode(collectionViewLayout: flowLayout))
        node.leadingScreensForBatching = 1.2
        node.delegate = self
        adapter.setASDKCollectionNode(node)
        adapter.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
}

// MARK: - ListAdapterDataSource
extension PhotoIGCollectionNodeController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        sections as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is PhotoIGHeaderSectionModel {
            return PhotoIGHeaderController()
        } else if object is PhotoIGFooterSectionModel {
            return PhotoIGFooterController()
        } else {
            return PhotoIGPhotosController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
      return nil
    }
}

// MARK: - ASCollectionDelegate
extension PhotoIGCollectionNodeController: ASCollectionDelegate {
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        true
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        guard let itemSection = sections.filter({ $0 is PhotoIGPhotoSectionModel }).first,
              let index = sections.firstIndex(of: itemSection) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let photos = self?.sections[index],
               let section = self?.adapter.sectionController(for: photos) as? PhotoIGPhotosController {
                section.beginBatchFetch(with: context)
            }
        }
    }
}
