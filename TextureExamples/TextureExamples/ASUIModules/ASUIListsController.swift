//
//  ASUIListsController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit

class ASUIListsController: BaseTableNodeController {

    private let viewModel: ASUIListsViewModelTypes = ASUIListsViewModel()
    private var dataSource: [ASUIListsModel] = []

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
        bindViewModel()
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
extension ASUIListsController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.row]
        let cellBlock: ASCellNodeBlock = {
            ASUIListsCellNode(item)
        }
        return cellBlock
    }
}

// MARK: - ASTableDelegate
extension ASUIListsController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        let item = dataSource[indexPath.row]

        var vc = BaseNodeController()

        switch item.type {
        case .image:
            vc = ImageNodeController()
        case .networkImage:
            vc = NetworkImageNodeController()
        case .text:
            vc = TextNodeController()
        case .button:
            vc = ButtonNodeController()
        case .map:
            vc = MapNodeController()
        default:
            break
        }
        vc.title = item.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
