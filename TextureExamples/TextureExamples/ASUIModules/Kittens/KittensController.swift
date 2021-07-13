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

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 2.5
        node.view.separatorStyle = .none
        viewModel.inputs.reloadItems()
    }

    func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                self?.dataSource.append(contentsOf: items)
                self?.node.reloadData()
            })
            .disposed(by: disposeBag)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            context.completeBatchFetching(true)
            self?.viewModel.inputs.reloadItems()
        }
    }
}
