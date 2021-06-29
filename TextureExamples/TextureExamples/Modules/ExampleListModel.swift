//
//  ExampleListModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import Foundation
import ObjectMapper

enum ExampleListSectionType: Int {
    case justifyContent = 0
    case alignItems
}

struct ExampleListSectionModel {
    var title: String?
    var type: ExampleListSectionType?
    var items: [ExampleListItemModel]?
}

extension ExampleListSectionModel: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        items <- map["items"]
    }
}

struct ExampleListItemModel {
    var title: String?
}

extension ExampleListItemModel: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["title"]
    }
}
