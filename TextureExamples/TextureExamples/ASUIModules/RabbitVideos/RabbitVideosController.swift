//
//  RabbitVideosController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/13.
//

import UIKit
import AsyncDisplayKit

class RabbitVideosController: BaseTableNodeController {

    private var dataSource: [RabbitVideosModel] = []
    private let viewModel: RabbitVideosViewModelTypes = RabbitVideosViewModel()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.viewDidAppear.onNext(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        node.dataSource = self
        node.delegate = self
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
extension RabbitVideosController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.row]
        let cell = {
            RabbitVideosCellNode(item)
        }
        return cell
    }
}

// MARK: - ASTableDelegate
extension RabbitVideosController: ASTableDelegate {

}
