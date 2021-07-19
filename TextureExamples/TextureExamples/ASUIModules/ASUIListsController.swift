//
//  ASUIListsController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit

class ASUIListsController: BaseTableNodeController {

    private let viewModel: ASUIListsViewModelTypes = ASUIListsViewModel()
    private var dataSource: [ASUIListsSectionModel] = []

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
        viewModel.outputs.sections
            .drive(onNext: { [weak self] sections in
                self?.dataSource = sections
                self?.node.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ASTableDataSource
extension ASUIListsController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        dataSource.count
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].items?.count ?? 0
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let section = dataSource[indexPath.section]
        let item = section.items?[indexPath.row]
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
        let section = dataSource[indexPath.section]
        let item = section.items?[indexPath.row]

        switch section.type {
        case .ui:
            selectUIControl(item)
        case .table:
            selectTableNode(item)
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

extension ASUIListsController {
    private func selectUIControl(_ item: ASUIListsModel?) {
        var vc = UIViewController()

        switch item?.type {
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
        case .editableText:
            vc = EditableTextNodeController()
        case .multiplexImage:
            vc = MultiplexNodeController()
        case .pager:
            vc = PagerNodeController()
        case .video:
            vc = VideoNodeController()
        case .scroll:
            vc = ScrollNodeController()
        default:
            break
        }
        vc.title = item?.title
        navigationController?.pushViewController(vc, animated: true)
    }

    private func selectTableNode(_ item: ASUIListsModel?) {
        var vc = UIViewController()

        switch item?.tableType {
        case .kitten:
            vc = KittensController()
        case .rabbit:
            vc = RabbitVideosController()
        case .ninePattern:
            vc = NinePatternsController()
        default:
            break
        }
        vc.title = item?.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
