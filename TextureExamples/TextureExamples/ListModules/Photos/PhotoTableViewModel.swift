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
}

protocol PhotoTableViewModelTypes {
    var inputs: PhotoTableViewModelInputs { get }
    var outputs: PhotoTableViewModelOutputs { get }
}

class PhotoTableViewModel: PhotoTableViewModelInputs, PhotoTableViewModelOutputs, PhotoTableViewModelTypes {
    
    init() {
        // inputs
        self.viewWillAppear = viewWillAppearSubject.asObserver()
        
        // outputs
    }
    
    // MARK: subjects
    let viewWillAppearSubject = PublishSubject<Void>()
    
    // MARK: inputs
    let viewWillAppear: AnyObserver<Void>

    // MARK: outputs

    var inputs: PhotoTableViewModelInputs { self }
    var outputs: PhotoTableViewModelOutputs { self }
}
