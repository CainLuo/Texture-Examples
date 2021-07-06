//
//  PhotoTableNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/5.
//

import RxSwift
import RxCocoa
import AsyncDisplayKit

class PhotoTableNodeController: BaseTableNodeController {

    private let viewModel: PhotoTableViewModelTypes = PhotoTableViewModel()
    private var dataSource: [PhotoTableModel] = []
    private let photoFeed = PhotoFeedModel(photoFeedModelType: .photoFeedModelTypePopular)
    private var context: ASBatchContext?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PhotoTableNode"
        bindViewModel()
        node.allowsSelection = false
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 2.5
        node.view.separatorStyle = .none
    }

    func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                items.forEach { item in
                    if self?.dataSource.filter({ $0.id == item.id }).isEmpty == true {
                        self?.dataSource.append(item)
                    }
                    self?.node.reloadData()
                    self?.context?.completeBatchFetching(true)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ASTableDataSource
extension PhotoTableNodeController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.row]
        let cell: ASCellNodeBlock = {
            PhotoTableCellNode(item)
        }
        return cell
    }
}

// MARK: - ASTableDelegate
extension PhotoTableNodeController: ASTableDelegate {
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        true
    }

    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.context = context
        viewModel.inputs.fetchList()
    }
}
