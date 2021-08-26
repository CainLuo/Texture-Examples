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
    
    private var sections: [PhotoIGSectionsModel] = [PhotoIGSectionsModel(type: .photos)]
    
    lazy var adapter: ListAdapter = {
        let listAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
        return listAdapter
    }()
    
    // Lifecycle
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(node: ASCollectionNode(collectionViewLayout: flowLayout))
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
        PhotoIGController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
      return nil
    }
}
