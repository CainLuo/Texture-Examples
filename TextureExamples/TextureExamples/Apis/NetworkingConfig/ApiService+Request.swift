//
//  ApiService.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/3/10.
//  Copyright © 2020 ve2. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Moya
import ObjectMapper
import Moya_ObjectMapper

// MARK: Moya Request Extension
extension ApiService {
    func request(_ target: Router) -> Single<Any> {
        apiProvider.request(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
    }
    
    func requestWithoutMapping(_ target: Router) -> Single<Moya.Response> {
        apiProvider.request(target)
            .observeOn(MainScheduler.instance)
    }
    
    func requestObject<T: BaseMappable>(_ target: Router, type: T.Type) -> Single<T> {
        apiProvider.request(target)
            .mapObject(T.self)
            .observeOn(MainScheduler.instance)
    }

    func requestArray<T: BaseMappable>(_ target: Router, type: T.Type) -> Single<[T]> {
        apiProvider.request(target)
            .mapArray(T.self)
            .observeOn(MainScheduler.instance)
    }
}
