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
    var items: Driver<[ASUIListsModel]> { get }
}

protocol ASUIListsViewModelTypes {
    var inputs: ASUIListsViewModelInputs { get }
    var outputs: ASUIListsViewModelOutputs { get }
}

class ASUIListsViewModel: ASUIListsViewModelInputs, ASUIListsViewModelOutputs, ASUIListsViewModelTypes {
    
    init() {
        let items = viewWillAppearSubject.map(dataSource)

        // inputs
        self.viewWillAppear = viewWillAppearSubject.asObserver()
        
        // outputs
        self.items = items.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    let viewWillAppear: AnyObserver<Void>

    // MARK: outputs
    let items: Driver<[ASUIListsModel]>

    var inputs: ASUIListsViewModelInputs { self }
    var outputs: ASUIListsViewModelOutputs { self }
}

private func dataSource() -> [ASUIListsModel] {
    [
        ASUIListsModel(title: "ASImageNode", type: .image),
        ASUIListsModel(title: "ASNetworkImageNode", type: .networkImage)
    ]
}
