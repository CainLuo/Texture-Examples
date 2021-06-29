//
//  ExampleListViewModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import Foundation
import RxSwift
import RxCocoa

protocol ExampleListViewModelInputs {
    func viewDidLoad()
}

protocol ExampleListViewModelOutputs {
    var sections: Driver<[ExampleListSectionModel]> { get }
}

protocol ExampleListViewModelTypes {
    var inputs: ExampleListViewModelInputs { get }
    var outputs: ExampleListViewModelOutputs { get }
}

class ExampleListViewModel: ExampleListViewModelInputs, ExampleListViewModelOutputs, ExampleListViewModelTypes {
    
    init() {
        let sections = viewDidLoadSubject.map(filterSections)
        
        // inputs
        
        // outputs
        self.sections = sections.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewDidLoadSubject = PublishSubject<Void>()
    
    // MARK: inputs
    func viewDidLoad() {
        viewDidLoadSubject.onNext(())
    }

    // MARK: outputs
    let sections: Driver<[ExampleListSectionModel]>

    var inputs: ExampleListViewModelInputs { return self }
    var outputs: ExampleListViewModelOutputs { return self }
}

private func filterSections() -> [ExampleListSectionModel] {
    [
        ExampleListSectionModel(title: "JustifyContent", type: .justifyContent, items: justifyContentItems()),
        ExampleListSectionModel(title: "AlignItems", type: .alignItems, items: justifyContentItems())
    ]
}

private func justifyContentItems() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "ASStackLayoutJustifyContentStart"),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentCenter"),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentEnd"),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentSpaceBetween"),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentSpaceAround")
    ]
}

private func alignItemsItems() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "ASStackLayoutAlignItemsStart"),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsEnd"),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsCenter"),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsStretch"),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsBaselineFirst"),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsBaselineLast"),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsNotSet")
    ]
}
