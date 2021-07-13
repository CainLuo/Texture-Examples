//
//  RabbitVideosModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/13.
//

import Foundation
import ObjectMapper

struct RabbitVideosModel {
    var title: String?
    var url: String?
    var username: String?
    var avatar: String?
}

extension RabbitVideosModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        url <- map["url"]
        username <- map["username"]
        avatar <- map["avatar"]
    }
}
