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
    var viewWillAppear: AnyObserver<Void> { get }
}

protocol PhotoTableViewModelOutputs {
    var items: Driver<[PhotoTableModel]> { get }
}

protocol PhotoTableViewModelTypes {
    var inputs: PhotoTableViewModelInputs { get }
    var outputs: PhotoTableViewModelOutputs { get }
}

private var page: String = "1"
class PhotoTableViewModel: PhotoTableViewModelInputs, PhotoTableViewModelOutputs, PhotoTableViewModelTypes {
    
    init() {
        let apiService: ApiService = ApiService()
        let error = ErrorTracker()
        
        let model = viewWillAppearSubject.map {
            PhotoTableSubmitModel(page: page)
        }
        
        let fetchLists = model
            .flatMap {
                apiService.getPhotos($0)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
            .share()
        
        // inputs
        self.viewWillAppear = viewWillAppearSubject.asObserver()
        
        // outputs
        self.items = fetchLists.asDriverOnErrorJustComplete()
    }
    
    // MARK: subjects
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    let viewWillAppear: AnyObserver<Void>

    // MARK: outputs
    let items: Driver<[PhotoTableModel]>

    var inputs: PhotoTableViewModelInputs { self }
    var outputs: PhotoTableViewModelOutputs { self }
}
