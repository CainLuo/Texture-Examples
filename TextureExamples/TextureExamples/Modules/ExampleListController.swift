//
//  ExampleListController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import RxSwift
import RxCocoa
import AsyncDisplayKit

class ExampleListController: BaseTableNodeController {
    
    private let viewModel: ExampleListViewModelTypes = ExampleListViewModel()
    private var dataSource: [ExampleListModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        node.allowsSelection = true
        node.dataSource = self
        node.delegate = self
        node.view.separatorStyle = .singleLine
        bindViewModel()
        viewModel.inputs.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                self?.dataSource = items
                self?.node.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ASTableDataSource
extension ExampleListController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.row]
        let cellBlock: ASCellNodeBlock = {
            ExampleListCellNode(item)
        }
        return cellBlock
    }
}

// MARK: - ASTableDelegate
extension ExampleListController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}
