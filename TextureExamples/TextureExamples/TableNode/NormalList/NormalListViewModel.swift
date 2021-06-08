//
//  NormalListViewModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/8.
//

import Foundation
import RxSwift
import RxCocoa

protocol NormalListViewModelInputs {
    func viewDidLoad()
}

protocol NormalListViewModelOutputs {
    var sections: Driver<[[NormalListModel]]> { get }
}

protocol NormalListViewModelTypes {
    var inputs: NormalListViewModelInputs { get }
    var outputs: NormalListViewModelOutputs { get }
}

class NormalListViewModel: NormalListViewModelInputs, NormalListViewModelOutputs, NormalListViewModelTypes {
    
    init() {
        let sections = viewWillAppearSubject.map(filterDataSource)
        
        // inputs
//        self.viewWillAppear = viewWillAppearSubject.asObserver()
        
        // outputs
        self.sections = sections.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    func viewDidLoad() {
        viewWillAppearSubject.onNext(())
    }

    // MARK: outputs
    let sections: Driver<[[NormalListModel]]>

    var inputs: NormalListViewModelInputs { return self }
    var outputs: NormalListViewModelOutputs { return self }
}

private func filterDataSource() -> [[NormalListModel]] {
    [
        filterSectionOne(),
        filterSectionTwo()
    ]
}

private func filterSectionOne() -> [NormalListModel] {
    [
        NormalListModel(title: "标题1"),
        NormalListModel(title: "标题2")
    ]
}

private func filterSectionTwo() -> [NormalListModel] {
    [
        NormalListModel(title: "标题1"),
        NormalListModel(title: "标题2"),
        NormalListModel(title: "标题3"),
        NormalListModel(title: "标题4"),
        NormalListModel(title: "标题5")
    ]
}
