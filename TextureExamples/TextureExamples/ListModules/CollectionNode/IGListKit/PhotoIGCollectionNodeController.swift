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
    
    private let disposeBag = DisposeBag()
    private let viewModel: PhotoTableViewModelTypes = PhotoTableViewModel()
    private var dataSource: [PhotoTableModel] = []
    private var batchContext: ASBatchContext?
    
    lazy var adapter: ListAdapter = {
      return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override init() {
        super.init(node: ASCollectionNode(collectionViewLayout: UICollectionViewFlowLayout()))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        adapter.setASDKCollectionNode(node)
        adapter.dataSource = self
        viewModel.inputs.fetchList()
        node.backgroundColor = .white
    }
    
    func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                guard !items.isEmpty else {
                    return
                }
                
                self?.dataSource.append(contentsOf:items)
                self?.adapter.performUpdates(animated: true)
                self?.batchContext?.completeBatchFetching(true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ListAdapterDataSource
extension PhotoIGCollectionNodeController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        dataSource
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        PhotoIGController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
      return nil
    }
}

// MARK: ASCollectionDelegate
extension PhotoIGCollectionNodeController: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        batchContext = context
        viewModel.inputs.fetchList()
    }
}
