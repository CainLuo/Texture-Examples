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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.viewWillAppear.onNext(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func bindViewModel() {
        viewModel.outputs.items
            .drive(onNext: { [weak self] items in
                items.forEach { item in
                    if self?.dataSource.filter({ $0.id == item.id }).isEmpty == true {
                        self?.dataSource.append(item)
                    }
                    self?.tableView.reloadData()
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PhotoTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
