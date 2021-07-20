//
//  RabbitVideosViewModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/13.
//

import Foundation
import RxSwift
import RxCocoa

protocol RabbitVideosViewModelInputs {
    var viewDidAppear: AnyObserver<Void> { get }
}

protocol RabbitVideosViewModelOutputs {
    var items: Driver<[RabbitVideosModel]> { get }
}

protocol RabbitVideosViewModelTypes {
    var inputs: RabbitVideosViewModelInputs { get }
    var outputs: RabbitVideosViewModelOutputs { get }
}

class RabbitVideosViewModel: RabbitVideosViewModelInputs, RabbitVideosViewModelOutputs, RabbitVideosViewModelTypes {
    
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
    let items: Driver<[RabbitVideosModel]>

    var inputs: RabbitVideosViewModelInputs { self }
    var outputs: RabbitVideosViewModelOutputs { self }
}

private func filterDataSource() -> [RabbitVideosModel] {
    var items: [RabbitVideosModel] = []

    for _ in 0...10 {
        items.append(RabbitVideosModel(title: "Rabbit Video",
                                       url: "https://www.w3schools.com/html/mov_bbb.mp4",
                                       username: "Rabbit",
                                       avatar: "https://placekitten.com/350/350"))
    }
    return items
}
