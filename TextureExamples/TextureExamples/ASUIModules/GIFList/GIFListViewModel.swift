//
//  GIFListViewModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/26.
//

import Foundation
import RxSwift
import RxCocoa

protocol GIFListViewModelInputs {
    func fetchList()
}

protocol GIFListViewModelOutputs {
    var items: Driver<[GIFListModel]> { get }
}

protocol GIFListViewModelTypes {
    var inputs: GIFListViewModelInputs { get }
    var outputs: GIFListViewModelOutputs { get }
}

class GIFListViewModel: GIFListViewModelInputs, GIFListViewModelOutputs, GIFListViewModelTypes {
    
    init() {
        let items = fetchListSubject.map(filterDataSource)
        // inputs

        // outputs
        self.items = items.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let fetchListSubject = PublishSubject<Void>()

    // MARK: inputs
    func fetchList() {
        fetchListSubject.onNext(())
    }

    // MARK: outputs
    let items: Driver<[GIFListModel]>

    var inputs: GIFListViewModelInputs { self }
    var outputs: GIFListViewModelOutputs { self }
}

private func filterDataSource() -> [GIFListModel] {
    var items: [GIFListModel] = []
    let url = "https://i.pinimg.com/originals/07/44/38/074438e7c75034df2dcf37ba1057803e.gif"

    for _ in 0...19 {
        items.append(GIFListModel(avatar: "https://placekitten.com/350/350", name: "Kitten", image: url))
    }

    return items
}
