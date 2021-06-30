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
        ExampleListSectionModel(title: "AlignItems", type: .alignItems, items: justifyContentItems()),
        ExampleListSectionModel(title: "AlignItems", type: .justifyAndAlign, items: justifyAndAlign()),
    ]
}

private func justifyContentItems() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "ASStackLayoutJustifyContentStart", justifyContent: .start),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentCenter", justifyContent: .center),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentEnd", justifyContent: .end),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentSpaceBetween", justifyContent: .spaceBetween),
        ExampleListItemModel(title: "ASStackLayoutJustifyContentSpaceAround", justifyContent: .spaceAround)
    ]
}

private func alignItemsItems() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "ASStackLayoutAlignItemsStart", alignItems: .start),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsEnd", alignItems: .end),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsCenter", alignItems: .center),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsStretch", alignItems: .stretch),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsBaselineFirst", alignItems: .baselineFirst),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsBaselineLast", alignItems: .baselineLast),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsNotSet", alignItems: .notSet)
    ]
}

private func justifyAndAlign() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "ASStackLayoutAlignItemsStart", justifyContent: .start, alignItems: .start),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsEnd", justifyContent: .center, alignItems: .end),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsCenter", justifyContent: .end, alignItems: .center),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsStretch", justifyContent: .spaceBetween, alignItems: .stretch),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsBaselineFirst", justifyContent: .spaceAround, alignItems: .baselineFirst),
        ExampleListItemModel(title: "ASStackLayoutAlignItemsBaselineLast", alignItems: .baselineLast)
    ]
}
