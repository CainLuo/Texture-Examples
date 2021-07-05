//
//  ApiNetworking.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/4/26.
//  Copyright © 2020 ve2. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

struct ApiNetworking: NetworkingType {
    typealias T = Router
    let provider: ApiProvider<T>

    static func defaultNetworking() -> ApiNetworking {
        ApiNetworking(provider: newProvider(plugins))
    }

    static func stubbingNetworking() -> ApiNetworking {
        ApiNetworking(provider: ApiProvider(endpointClosure: endpointsClosure(),
                                            requestClosure: ApiNetworking.endpointResolver(),
                                            stubClosure: MoyaProvider.immediatelyStub))
    }

    func request(_ token: T) -> Single<Response> {
        provider.request(token)
    }
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> ApiProvider<T> {
    ApiProvider(endpointClosure: ApiNetworking.endpointsClosure(xAccessToken),
                requestClosure: ApiNetworking.endpointResolver(),
                stubClosure: ApiNetworking.APIKeysBasedStubBehaviour,
                plugins: plugins)
}
