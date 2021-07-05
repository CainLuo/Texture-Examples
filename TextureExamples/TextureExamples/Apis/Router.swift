//
//  Router.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/3/10.
//  Copyright © 2020 ve2. All rights reserved.
//

import Moya
import Alamofire

enum Router {
    
    // MARK: Camera
    case getPhotos(paremters: Parameters)
}

extension Router: TargetType {
    var baseURL: URL {
        URL(string: "https://api.unsplash.com/")!
    }
    
    var path: String {
        switch self {
        // MARK: Camera
        case .getPhotos:
            return "photos"
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        "".data(using: String.Encoding.utf8) ?? Data()
    }
    
    var task: Task {
        switch self {
        case .getPhotos(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]?  {
        [:]
    }
}
