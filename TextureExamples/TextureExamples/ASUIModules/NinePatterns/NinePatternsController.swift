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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.viewDidAppear.onNext(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
                self?.dataSource.append(contentsOf: items)
                self?.node.reloadData()
            })
            .disposed(by: disposeBag)
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
//    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
//        tableNode.deselectRow(at: indexPath, animated: true)
//        if let cell = tableNode.nodeForRow(at: indexPath) as? KittensCellNode {
//            cell.toggleImageEnlargement()
//        }
//    }
}
