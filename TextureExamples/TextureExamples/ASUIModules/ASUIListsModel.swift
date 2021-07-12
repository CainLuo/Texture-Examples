//
//  ASUIListsModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import Foundation
import ObjectMapper

enum ASUIListsType {
    case image
    case networkImage
    case text
    case button
    case map
    case editableText
}

struct ASUIListsModel {
    var title: String?
    var type: ASUIListsType?
}

extension ASUIListsModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
    }
}
