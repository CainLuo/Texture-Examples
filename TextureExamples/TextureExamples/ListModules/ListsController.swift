//
//  ListsController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/1.
//

import AsyncDisplayKit

class ListsController: BaseTableNodeController {
    
    private let viewModel: ListsViewModelTypes = ListsViewModel()
    private var dataSource: [ListsSectionsModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.viewWillAppear.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        node.allowsSelection = true
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 2.5
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.outputs.sections
            .drive(onNext: { [weak self] sections in
                self?.dataSource = sections
                self?.node.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ASTableDataSource
extension ListsController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        dataSource.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].items?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.section].items?[indexPath.row]
        let cellBlock: ASCellNodeBlock = {
            ListsCellNode(item)
        }
        return cellBlock
    }
}

// MARK: - ASTableDelegate
extension ListsController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        
        let section = dataSource[indexPath.section]
        guard let item = section.items?[indexPath.row] else {
            return
        }
        
        switch section.type {
        case .table:
            let vc = item.type == .asyncDisplayKit ? PhotoTableNodeController() : PhotoTableViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .collection:
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataSource[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}
