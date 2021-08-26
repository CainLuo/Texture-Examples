//
//  ExampleListModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import Foundation
import ObjectMapper
import AsyncDisplayKit

enum ExampleListSectionType: Int {
    case justifyContent = 0
    case alignItems
    case justifyAndAlign
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
    var justifyContent: ASStackLayoutJustifyContent?
    var alignItems: ASStackLayoutAlignItems?
}

extension ExampleListItemModel: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["title"]
        justifyContent <- map["justifyContent"]
        alignItems <- map["alignItems"]
    }
}
