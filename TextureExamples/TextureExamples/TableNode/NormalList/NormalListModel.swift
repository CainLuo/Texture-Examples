//
//  NormalListModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/8.
//

import Foundation
import ObjectMapper

struct NormalListModel {
    var title: String?
}

extension NormalListModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
    }
}
