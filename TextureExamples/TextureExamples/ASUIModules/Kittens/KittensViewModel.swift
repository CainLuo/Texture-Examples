//
//  KittensViewModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/13.
//

import Foundation
import RxSwift
import RxCocoa

protocol KittensViewModelInputs {
    func reloadItems()
}

protocol KittensViewModelOutputs {
    var items: Driver<[CGSize]> { get }
}

protocol KittensViewModelTypes {
    var inputs: KittensViewModelInputs { get }
    var outputs: KittensViewModelOutputs { get }
}

class KittensViewModel: KittensViewModelInputs, KittensViewModelOutputs, KittensViewModelTypes {
    
    init() {
        let items = reloadSubject.map(filterDataSource)
        // inputs

        // outputs
        self.items = items.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let reloadSubject = PublishSubject<Void>()

    // MARK: inputs
    func reloadItems() {
        reloadSubject.onNext(())
    }

    // MARK: outputs
    let items: Driver<[CGSize]>

    var inputs: KittensViewModelInputs { self }
    var outputs: KittensViewModelOutputs { self }
}

private func filterDataSource() -> [CGSize] {
    var items: [CGSize] = []

    for _ in 0...19 {
        let width = Int(arc4random_uniform(300) + 100)
        let height = Int(arc4random_uniform(350) + 100)
        items.append(CGSize(width: width, height: height))
    }

    return items
}
