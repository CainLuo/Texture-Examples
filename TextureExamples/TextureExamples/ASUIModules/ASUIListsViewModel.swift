//
//  ASUIListsViewModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import Foundation
import RxSwift
import RxCocoa

protocol ASUIListsViewModelInputs {
    var viewWillAppear: AnyObserver<Void> { get }
}

protocol ASUIListsViewModelOutputs {
    var sections: Driver<[ASUIListsSectionModel]> { get }
    var items: Driver<[ASUIListsModel]> { get }
}

protocol ASUIListsViewModelTypes {
    var inputs: ASUIListsViewModelInputs { get }
    var outputs: ASUIListsViewModelOutputs { get }
}

class ASUIListsViewModel: ASUIListsViewModelInputs, ASUIListsViewModelOutputs, ASUIListsViewModelTypes {
    
    init() {
        let sections = viewWillAppearSubject.map(filterSections)
        let items = viewWillAppearSubject.map(controlsDataSource)

        // inputs
        self.viewWillAppear = viewWillAppearSubject.asObserver()
        
        // outputs
        self.sections = sections.asDriverOnErrorJustComplete()
        self.items = items.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    let viewWillAppear: AnyObserver<Void>

    // MARK: outputs
    let sections: Driver<[ASUIListsSectionModel]>
    let items: Driver<[ASUIListsModel]>

    var inputs: ASUIListsViewModelInputs { self }
    var outputs: ASUIListsViewModelOutputs { self }
}

private func filterSections() -> [ASUIListsSectionModel] {
    [
        ASUIListsSectionModel(title: "AS Controls", type: .ui, items: controlsDataSource()),
        ASUIListsSectionModel(title: "AS Table Node", type: .table, items: tablesDataSource())
    ]
}

private func controlsDataSource() -> [ASUIListsModel] {
    [
        ASUIListsModel(title: "ASImageNode", type: .image),
        ASUIListsModel(title: "ASNetworkImageNode", type: .networkImage),
        ASUIListsModel(title: "ASTextNode", type: .text),
        ASUIListsModel(title: "ASButtonNode", type: .button),
        ASUIListsModel(title: "ASMapNode", type: .map),
        ASUIListsModel(title: "ASEditableTextNode", type: .editableText),
        ASUIListsModel(title: "ASMultiplexImageNode", type: .multiplexImage),
        ASUIListsModel(title: "ASPagerNode", type: .pager),
        ASUIListsModel(title: "ASVideoNode", type: .video),
        ASUIListsModel(title: "ASScrollNode", type: .scroll)
    ]
}

private func tablesDataSource() -> [ASUIListsModel] {
    [
        ASUIListsModel(title: "Kittens", tableType: .kitten),
        ASUIListsModel(title: "Rabbit Videos", tableType: .rabbit)
    ]
}
