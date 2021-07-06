//
//  PhotoTableViewModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/5.
//

import Foundation
import RxSwift
import RxCocoa

protocol PhotoTableViewModelInputs {
    func fetchList()
}

protocol PhotoTableViewModelOutputs {
    var items: Driver<[PhotoTableModel]> { get }
}

protocol PhotoTableViewModelTypes {
    var inputs: PhotoTableViewModelInputs { get }
    var outputs: PhotoTableViewModelOutputs { get }
}

private var page: Int = 1
class PhotoTableViewModel: PhotoTableViewModelInputs, PhotoTableViewModelOutputs, PhotoTableViewModelTypes {
    
    init() {
        let apiService: ApiService = ApiService()
        let error = ErrorTracker()
        
        let model = fetchListSubject.map {
            PhotoTableSubmitModel(page: "\(page)")
        }
        
        let fetchLists = model
            .flatMap {
                apiService.getPhotos($0)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }.do(onNext: { _ in
                page += 1
            })
            .share()

        // inputs

        // outputs
        self.items = fetchLists.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let fetchListSubject = PublishSubject<Void>()

    // MARK: inputs
    func fetchList() {
        fetchListSubject.onNext(())
    }

    // MARK: outputs
    let items: Driver<[PhotoTableModel]>

    var inputs: PhotoTableViewModelInputs { self }
    var outputs: PhotoTableViewModelOutputs { self }
}
