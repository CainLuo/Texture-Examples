//
//  NinePatternsModel.swift
//  NinePatternsModel
//
//  Created by CainLuo on 2021/7/19.
//

import Foundation
import ObjectMapper

struct NinePatternsModel {
    var avatar: String?
    var name: String?
    var image: [String] = []
}

extension NinePatternsModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        avatar <- map["avatar"]
        name <- map["name"]
        image <- map["image"]
    }
}
