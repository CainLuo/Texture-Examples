//
//  PhotoTableViewController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/5.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: PhotoTableViewModelTypes = PhotoTableViewModel()
    private var dataSource: [PhotoTableModel] = []
    private var isLoading: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "PhotoTableView"
        bindViewModel()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoTableViewCell")
        viewModel.inputs.fetchList()
    }
    
    func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                items.forEach { item in
                    if self?.dataSource.filter({ $0.id == item.id }).isEmpty == true {
                        self?.dataSource.append(item)
                    }
                }
                self?.tableView.reloadData()
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension PhotoTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {
            fatalError("Wrong cell type")
        }
        cell.configItem(dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PhotoTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PhotoTableViewCell.height(
            for: dataSource[indexPath.row],
            withWidth: self.view.frame.size.width
        )
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = UIScreen.main.bounds.height
        let screenfullsBeforeBottom = (contentHeight - currentOffSetY) / screenHeight
        if screenfullsBeforeBottom < 2.5 {
            if !isLoading {
                viewModel.inputs.fetchList()
                isLoading = true
            }
        }
    }
}
