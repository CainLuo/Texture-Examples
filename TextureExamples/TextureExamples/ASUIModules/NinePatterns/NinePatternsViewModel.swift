//
//  NinePatternsViewModel.swift
//  NinePatternsViewModel
//
//  Created by CainLuo on 2021/7/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol NinePatternsViewModelInputs {
    var viewDidAppear: AnyObserver<Void> { get }
}

protocol NinePatternsViewModelOutputs {
    var items: Driver<[NinePatternsModel]> { get }
}

protocol NinePatternsViewModelTypes {
    var inputs: NinePatternsViewModelInputs { get }
    var outputs: NinePatternsViewModelOutputs { get }
}

class NinePatternsViewModel: NinePatternsViewModelInputs, NinePatternsViewModelOutputs, NinePatternsViewModelTypes {
    
    init() {
        
        let items = viewDidAppearSubject.map(filterDataSource)
        
        // inputs
        self.viewDidAppear = viewDidAppearSubject.asObserver()
        
        // outputs
        self.items = items.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewDidAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    let viewDidAppear: AnyObserver<Void>

    // MARK: outputs
    let items: Driver<[NinePatternsModel]>

    var inputs: NinePatternsViewModelInputs { return self }
    var outputs: NinePatternsViewModelOutputs { return self }
}

private func filterDataSource() -> [NinePatternsModel] {
    var items: [NinePatternsModel] = []
    
    for _ in 0...19 {
        var urls: [String] = []
        for _ in 0..<arc4random_uniform(9) {
            let width = Int(arc4random_uniform(300) + 100)
            let height = Int(arc4random_uniform(350) + 100)
            urls.append("https://placekitten.com/\(width)/\(height)")
        }
        if urls.isEmpty {
            urls.append("https://placekitten.com/350/350")
        }
        items.append(NinePatternsModel(avatar: "https://placekitten.com/350/350", name: "Kitten", image: urls))
    }
    
    return items
}
