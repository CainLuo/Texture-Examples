//
//  SessionManager.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/3/10.
//  Copyright © 2020 ve2. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Moya

let session: Session = {
    let configuration = URLSessionConfiguration.default
    configuration.headers = .default
    configuration.timeoutIntervalForRequest = 20
    configuration.timeoutIntervalForResource = 20
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    
    return Session(configuration: configuration)
}()
