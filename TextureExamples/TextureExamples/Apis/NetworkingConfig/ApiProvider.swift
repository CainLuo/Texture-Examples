//
//  ApiProvider.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/4/26.
//  Copyright © 2020 ve2. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

final class ApiProvider<Target> where Target: TargetType {
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = session,
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ target: Target) -> Single<Moya.Response> {
        Single.create { single -> Disposable in
            let request: Disposable = self.provider.rx.request(target)
                .subscribe(onSuccess: { response in
                    do {
                        let response: Response = try response.filterSuccessfulStatusCodes()
                        single(.success(response))
                    } catch let error {
                        let fetchError: NSError = error as NSError
                        if fetchError.code != 200 {
                            single(.error(newError(.business) as Error))
                        } else {
                            single(.error(error))
                        }
                        print("💥💥💥Error Code: \(fetchError.code), message: \(error.localizedDescription)💥💥💥")
                    }
                }, onError: { error in
                    let fetchError: NSError = error as NSError
                    if fetchError.code != 200 {
                        single(.error(newError(.business) as Error))
                    } else {
                        single(.error(error))
                    }
                    print("💥💥💥Error Code: \(fetchError.code), message: \(error.localizedDescription)💥💥💥")
                })
            
            return Disposables.create { request.dispose() }
        }
    }
}
