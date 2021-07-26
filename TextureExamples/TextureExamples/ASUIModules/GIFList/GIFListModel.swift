//
//  GIFListModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/26.
//

import Foundation
import ObjectMapper

struct GIFListModel {
    var avatar: String?
    var name: String?
    var image: String?
}

extension GIFListModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        avatar <- map["avatar"]
        name <- map["name"]
        image <- map["image"]
    }
}
