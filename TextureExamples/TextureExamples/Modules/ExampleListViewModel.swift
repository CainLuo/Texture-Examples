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
    var items: Driver<[ExampleListModel]> { get }
}

protocol ExampleListViewModelTypes {
    var inputs: ExampleListViewModelInputs { get }
    var outputs: ExampleListViewModelOutputs { get }
}

class ExampleListViewModel: ExampleListViewModelInputs, ExampleListViewModelOutputs, ExampleListViewModelTypes {
    
    init() {
        let items = viewDidLoadSubject.map(filterItems)
        
        // inputs
        
        // outputs
        self.items = items.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewDidLoadSubject = PublishSubject<Void>()
    
    // MARK: inputs
    func viewDidLoad() {
        viewDidLoadSubject.onNext(())
    }

    // MARK: outputs
    let items: Driver<[ExampleListModel]>

    var inputs: ExampleListViewModelInputs { return self }
    var outputs: ExampleListViewModelOutputs { return self }
}

private func filterItems() -> [ExampleListModel] {
    [
        ExampleListModel(title: "aaaaa")
    ]
}
