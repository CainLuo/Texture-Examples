//
//  LayoutsModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import Foundation
import ObjectMapper

enum LayoutsSectionType {
    case original
    case textureSwiftSupport
}

enum LayoutsItemType {
    case wrapper
    case stack
    case inset
    case overlay
    case background
    case center
    case ratio
    case relative
    case absolute
    case corner
}

// MARK: - LayoutsSectionModel
struct LayoutsSectionModel {
    var title: String?
    var type: LayoutsSectionType?
    var items: [LayoutsItemModel]?
}

extension LayoutsSectionModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        items <- map["items"]
    }
}

// MARK: - LayoutsItemModel
struct LayoutsItemModel {
    var title: String?
    var type: LayoutsItemType?
}

extension LayoutsItemModel: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
    }
}
