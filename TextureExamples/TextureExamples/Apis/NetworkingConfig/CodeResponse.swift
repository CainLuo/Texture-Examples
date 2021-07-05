//
//  CodeResponse.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/4/26.
//  Copyright © 2020 ve2. All rights reserved.
//

import Foundation
import ObjectMapper

class CodeResponse: NSObject, Mappable {
    var code: Int = -1
    var data: String?
    
    @objc var jsonDta: String? {
        get {
            data
        }
    }

    required init?(map: Map) { }

    func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
    }

    @objc static func jsonToModel(_ json: [String: Any]) -> CodeResponse? {
        CodeResponse(JSON: json)
    }
}
