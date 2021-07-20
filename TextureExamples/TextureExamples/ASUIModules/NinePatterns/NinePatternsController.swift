//
//  NinePatternsController.swift
//  NinePatternsController
//
//  Created by CainLuo on 2021/7/19.
//

import AsyncDisplayKit
import TextureSwiftSupport

class NinePatternsController: BaseTableNodeController {

    private var dataSource: [NinePatternsModel] = []
    private let viewModel: NinePatternsViewModelTypes = NinePatternsViewModel()
    private var context: ASBatchContext?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        node.allowsSelection = false
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 1.5
        node.view.separatorStyle = .none
    }

    func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                self?.reloadTableNode(items)
            })
            .disposed(by: disposeBag)
    }
    
    private func reloadTableNode(_ items: [NinePatternsModel]) {
        var indexPaths: [IndexPath] = []
        let endIndex = dataSource.count
        
        for index in 0..<items.count {
            indexPaths.append(IndexPath(row: index + endIndex, section: 0))
        }
        
        dataSource.append(contentsOf: items)
        node.insertRows(at: indexPaths, with: .automatic)
        context?.completeBatchFetching(true)
    }
}

// MARK: - ASTableDataSource
extension NinePatternsController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.row]
        let cell = {
            NinePatternsCellNode(item)
        }
        return cell
    }
}

// MARK: - ASTableDelegate
extension NinePatternsController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.context = context
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.viewModel.inputs.viewDidAppear.onNext(())
        }
    }
}
