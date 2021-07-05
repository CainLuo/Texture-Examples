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
        ExampleListSectionModel(title: "AlignItems", type: .alignItems, items: alignItemsItems()),
        ExampleListSectionModel(title: "JustifyContentStart And AlignItems", type: .justifyAndAlign, items: justifyStartAndAlign()),
        ExampleListSectionModel(title: "JustifyContentCenter And AlignItems", type: .justifyAndAlign, items: justifyCenterAndAlign()),
        ExampleListSectionModel(title: "JustifyContentEnd And AlignItems", type: .justifyAndAlign, items: justifyEndAndAlign()),
        ExampleListSectionModel(title: "JustifyContentSpaceBetween And AlignItems", type: .justifyAndAlign, items: justifySpaceBetweenAndAlign()),
        ExampleListSectionModel(title: "JustifyContentSpaceAround And AlignItems", type: .justifyAndAlign, items: justifySpaceAroundAndAlign())
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

private func justifyStartAndAlign() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "JustifyContentStart and AlignItemsStart", justifyContent: .start, alignItems: .start),
        ExampleListItemModel(title: "JustifyContentStart and AlignItemsEnd", justifyContent: .start, alignItems: .end),
        ExampleListItemModel(title: "JustifyContentStart and AlignItemsCenter", justifyContent: .start, alignItems: .center),
        ExampleListItemModel(title: "JustifyContentStart and AlignItemsStretch", justifyContent: .start, alignItems: .stretch),
        ExampleListItemModel(title: "JustifyContentStart and AlignItemsBaselineFirst", justifyContent: .start, alignItems: .baselineFirst),
        ExampleListItemModel(title: "JustifyContentStart and AlignItemsBaselineLast", justifyContent: .start, alignItems: .baselineLast)
    ]
}

private func justifyEndAndAlign() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "JustifyContentEnd and AlignItemsStart", justifyContent: .end, alignItems: .start),
        ExampleListItemModel(title: "JustifyContentEnd and AlignItemsEnd", justifyContent: .end, alignItems: .end),
        ExampleListItemModel(title: "JustifyContentEnd and AlignItemsCenter", justifyContent: .end, alignItems: .center),
        ExampleListItemModel(title: "JustifyContentEnd and AlignItemsStretch", justifyContent: .end, alignItems: .stretch),
        ExampleListItemModel(title: "JustifyContentEnd and AlignItemsBaselineFirst", justifyContent: .end, alignItems: .baselineFirst),
        ExampleListItemModel(title: "JustifyContentEnd and AlignItemsBaselineLast", justifyContent: .end, alignItems: .baselineLast)
    ]
}

private func justifyCenterAndAlign() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "JustifyContentCenter and AlignItemsStart", justifyContent: .center, alignItems: .start),
        ExampleListItemModel(title: "JustifyContentCenter and AlignItemsEnd", justifyContent: .center, alignItems: .end),
        ExampleListItemModel(title: "JustifyContentCenter and AlignItemsCenter", justifyContent: .center, alignItems: .center),
        ExampleListItemModel(title: "JustifyContentCenter and AlignItemsStretch", justifyContent: .center, alignItems: .stretch),
        ExampleListItemModel(title: "JustifyContentCenter and AlignItemsBaselineFirst", justifyContent: .center, alignItems: .baselineFirst),
        ExampleListItemModel(title: "JustifyContentCenter and AlignItemsBaselineLast", justifyContent: .center, alignItems: .baselineLast)
    ]
}

private func justifySpaceBetweenAndAlign() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "JustifyContentSpaceBetween and AlignItemsStart", justifyContent: .spaceBetween, alignItems: .start),
        ExampleListItemModel(title: "JustifyContentSpaceBetween and AlignItemsEnd", justifyContent: .spaceBetween, alignItems: .end),
        ExampleListItemModel(title: "JustifyContentSpaceBetween and AlignItemsCenter", justifyContent: .spaceBetween, alignItems: .center),
        ExampleListItemModel(title: "JustifyContentSpaceBetween and AlignItemsStretch", justifyContent: .spaceBetween, alignItems: .stretch),
        ExampleListItemModel(title: "JustifyContentSpaceBetween and AlignItemsBaselineFirst", justifyContent: .spaceBetween, alignItems: .baselineFirst),
        ExampleListItemModel(title: "JustifyContentSpaceBetween and AlignItemsBaselineLast", justifyContent: .spaceBetween, alignItems: .baselineLast)
    ]
}

private func justifySpaceAroundAndAlign() -> [ExampleListItemModel] {
    [
        ExampleListItemModel(title: "JustifyContentSpaceAround and AlignItemsStart", justifyContent: .spaceAround, alignItems: .start),
        ExampleListItemModel(title: "JustifyContentSpaceAround and AlignItemsEnd", justifyContent: .spaceAround, alignItems: .end),
        ExampleListItemModel(title: "JustifyContentSpaceAround and AlignItemsCenter", justifyContent: .spaceAround, alignItems: .center),
        ExampleListItemModel(title: "JustifyContentSpaceAround and AlignItemsStretch", justifyContent: .spaceAround, alignItems: .stretch),
        ExampleListItemModel(title: "JustifyContentSpaceAround and AlignItemsBaselineFirst", justifyContent: .spaceAround, alignItems: .baselineFirst),
        ExampleListItemModel(title: "JustifyContentSpaceAround and AlignItemsBaselineLast", justifyContent: .spaceAround, alignItems: .baselineLast)
    ]
}
