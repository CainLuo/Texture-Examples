//
//  ListsViewModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/5.
//

import Foundation
import RxSwift
import RxCocoa

protocol ListsViewModelInputs {
    var viewWillAppear: AnyObserver<Void> { get }
}

protocol ListsViewModelOutputs {
    var sections: Driver<[ListsSectionsModel]> { get }
}

protocol ListsViewModelTypes {
    var inputs: ListsViewModelInputs { get }
    var outputs: ListsViewModelOutputs { get }
}

class ListsViewModel: ListsViewModelInputs, ListsViewModelOutputs, ListsViewModelTypes {
    
    init() {
        let sections = viewWillAppearSubject.map(filterSections)
        
        // inputs
        self.viewWillAppear = viewWillAppearSubject.asObserver()
        
        // outputs
        self.sections = sections.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    let viewWillAppear: AnyObserver<Void>

    // MARK: outputs
    let sections: Driver<[ListsSectionsModel]>

    var inputs: ListsViewModelInputs { return self }
    var outputs: ListsViewModelOutputs { return self }
}

private func filterSections() -> [ListsSectionsModel] {
    [
        ListsSectionsModel(title: "Tables", type: .table, items: tablesItems()),
        ListsSectionsModel(title: "Collections", type: .collection, items: collectionsItems())
    ]
}

private func tablesItems() -> [ListsItemsModel] {
    [
        ListsItemsModel(title: "UIKit-TableView", type: .uikit),
        ListsItemsModel(title: "AsyncDisplayKit-TableNode", type: .asyncDisplayKit)
    ]
}

private func collectionsItems() -> [ListsItemsModel] {
    [
        ListsItemsModel(title: "UIKit-CollectionView", type: .uikit),
        ListsItemsModel(title: "AsyncDisplayKit-CollectionNode", type: .asyncDisplayKit),
        ListsItemsModel(title: "IGListKit-CollectionNode", type: .asyncDisplayKit)
    ]
}
