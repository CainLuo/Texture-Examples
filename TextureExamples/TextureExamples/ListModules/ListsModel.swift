//
//  ListsModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/5.
//

import Foundation
import ObjectMapper

enum ListsSectionType {
    case table
    case collection
}

enum ListsItemType {
    case uikit
    case asyncDisplayKit
    case igList
}

enum ListsItemCollectionType {
    case photo
    case normal
    case custom
}

// MARK: - ListsSectionsModel
struct ListsSectionsModel {
    var title: String?
    var type: ListsSectionType?
    var items: [ListsItemsModel]?
}

extension ListsSectionsModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        items <- map["items"]
    }
}

// MARK: - ListsItemsModel
struct ListsItemsModel {
    var title: String?
    var type: ListsItemType?
    var collectionType: ListsItemCollectionType?
}

extension ListsItemsModel: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        collectionType <- map["ListsItemCollectionType"]
    }
}
