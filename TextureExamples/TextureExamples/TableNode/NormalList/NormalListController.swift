//
//  NormalListController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/8.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

class NormalListController: ASDKViewController<ASTableNode> {
    
    private let disposeBag = DisposeBag()
    private let viewModel: NormalListViewModelTypes = NormalListViewModel()
    
    private var dataSource: [[NormalListModel]] = []
    
    override init() {
        super.init(node: ASTableNode())
        
        navigationItem.title = "ASDK"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        view.backgroundColor = .white
        
        node.allowsSelection = true
        node.dataSource = self
        node.delegate = self
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        view.backgroundColor = .clear
        node.view.tableFooterView = view

        viewModel.inputs.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.outputs.sections
            .drive(onNext: { [weak self] sections in
                self?.dataSource = sections
                self?.node.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ASTableDataSource
extension NormalListController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        dataSource.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.section][indexPath.row]
        let cellNodeBlock: ASCellNodeBlock = {
            let cell = NormalNodeCell()
            cell.configItem(item)
            return cell
        }
        
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let node = ASCellNode()
        node.backgroundColor = .gray
        return node
    }
}

// MARK: - ASTableDelegate
extension NormalListController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        ASSizeRange(min: CGSize(width: tableNode.frame.size.width, height: 60),
                    max: CGSize(width: tableNode.frame.size.width, height: 60))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ["section1", "section2"][section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}
