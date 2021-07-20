//
//  KittensController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/13.
//

import AsyncDisplayKit
import TextureSwiftSupport

class KittensController: BaseTableNodeController {

    private var dataSource: [CGSize] = []
    private let viewModel: KittensViewModelTypes = KittensViewModel()
    private var context: ASBatchContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
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
    
    private func reloadTableNode(_ items: [CGSize]) {
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
extension KittensController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.row]
        let cell = {
            KittensCellNode(item)
        }
        return cell
    }
}

// MARK: - ASTableDelegate
extension KittensController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        if let cell = tableNode.nodeForRow(at: indexPath) as? KittensCellNode {
            cell.toggleImageEnlargement()
        }
    }

    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.context = context
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.viewModel.inputs.reloadItems()
        }
    }
}
