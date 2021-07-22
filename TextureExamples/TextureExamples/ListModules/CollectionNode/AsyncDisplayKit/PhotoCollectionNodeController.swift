//
//  PhotoCollectionNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import AsyncDisplayKit

class PhotoCollectionNodeController: BaseNodeController {

    private var context: ASBatchContext?
    private var dataSource: [PhotoTableModel] = []
    private let viewModel: PhotoTableViewModelTypes = PhotoTableViewModel()

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.width / 2)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private lazy var collectionNode: ASCollectionNode = {
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        collectionNode.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionNode.backgroundColor = .white
        collectionNode.frame = view.bounds
        collectionNode.delegate = self
        collectionNode.dataSource = self
        return collectionNode
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubnode(collectionNode)
        bindViewModel()
        title = "CollectionNodePhotos"
    }

    func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                items.forEach { item in
                    if self?.dataSource.filter({ $0.id == item.id }).isEmpty == true {
                        self?.dataSource.append(item)
                    }
                    self?.collectionNode.reloadData()
                    self?.context?.completeBatchFetching(true)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ASCollectionDataSource
extension PhotoCollectionNodeController: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.row]
        let cellNodeBlock: ASCellNodeBlock = {
            PhotoCollectionCellNode(item)
        }
        return cellNodeBlock
    }
}

// MARK: - ASCollectionDelegate
extension PhotoCollectionNodeController: ASCollectionDelegate {
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        true
    }

    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.context = context
        viewModel.inputs.fetchList()
    }
}
