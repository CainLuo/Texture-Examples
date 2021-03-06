//
//  LayoutsController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import AsyncDisplayKit

class LayoutsController: BaseTableNodeController {

    private let viewModel: LayoutsViewModelTypes = LayoutsViewModel()
    private var dataSource: [LayoutsSectionModel] = []

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
extension LayoutsController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        dataSource.count
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].items?.count ?? 0
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = dataSource[indexPath.section].items?[indexPath.row]
        let cellBlock: ASCellNodeBlock = {
            LayoutsCellNode(item)
        }
        return cellBlock
    }
}

// MARK: - ASTableDelegate
extension LayoutsController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)

        let section = dataSource[indexPath.section]
        guard let type = section.type,
              let item = section.items?[indexPath.row] else {
            return
        }

        var vc = BaseNodeController()

        switch item.type {
        case .wrapper:
            vc = WrapperLayoutController(type)
        case .stack:
            vc = StackLayoutController(type)
        case .inset:
            vc = InsetLayoutController(type)
        case .overlay:
            vc = OverlayLayoutController(type)
        case .background:
            vc = BackgroundLayoutController(type)
        case .center:
            vc = CenterLayoutController(type)
        case .ratio:
            vc = RatioLayoutController(type)
        case .relative:
            vc = RelativeLayoutController(type)
        case .absolute:
            vc = AbsoluteLayoutController(type)
        case .corner:
            vc = CornerLayoutController()
        default:
            break
        }
        vc.title = item.title
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataSource[section].title
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}
