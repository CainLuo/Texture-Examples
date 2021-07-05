//
//  ApiService.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/3/10.
//  Copyright © 2020 ve2. All rights reserved.
//

import Alamofire
import RxSwift
import Moya
import ObjectMapper

class ApiService: ApiServiceType {

    let apiProvider: ApiNetworking
    
    init() {
        self.apiProvider = ApiNetworking.defaultNetworking()
    }
}

extension ApiService {
    // MARK: Photos
    func getPhotos(_ model: PhotoTableSubmitModel) -> Single<[PhotoTableModel]> {
        requestArray(.getPhotos(paremters: model.toJSON()), type: PhotoTableModel.self)
    }
}
