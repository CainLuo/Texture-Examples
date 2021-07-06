//
//  PhotoCollectionViewController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "PhotoCollectionViewCell"

class PhotoCollectionViewController: UICollectionViewController {

    private let disposeBag = DisposeBag()
    private var dataSource: [PhotoTableModel] = []
    private let viewModel: PhotoTableViewModelTypes = PhotoTableViewModel()
    private var isLoading: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        bindViewModel()
        title = "PhotoCollectionView"
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
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
                self?.collectionView.reloadData()
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("")
        }
        cell.configItem(dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoCollectionViewController {
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

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.width / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
