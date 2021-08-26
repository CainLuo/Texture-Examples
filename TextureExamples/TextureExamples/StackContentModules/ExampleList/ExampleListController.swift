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
    private var dataSource: [ExampleListSectionModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        node.allowsSelection = true
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 2.5
        bindViewModel()
        viewModel.inputs.viewDidLoad()
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
extension ExampleListController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        dataSource.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].items?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.section].items?[indexPath.row]
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
        
        let section = dataSource[indexPath.section]
        guard let item = section.items?[indexPath.row] else {
            return
        }
        
        switch section.type {
        case .justifyContent:
            let vc = JustifyContentController(item.justifyContent ?? .start)
            vc.title = item.title
            navigationController?.pushViewController(vc, animated: true)
        case .alignItems:
            let vc = AlignItemsController(item.alignItems ?? .start)
            vc.title = item.title
            navigationController?.pushViewController(vc, animated: true)
        case .justifyAndAlign:
            let vc = AlignAndJustifyController(item.alignItems ?? .start, justify: item.justifyContent ?? .start)
            vc.title = item.title
            navigationController?.pushViewController(vc, animated: true)
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
