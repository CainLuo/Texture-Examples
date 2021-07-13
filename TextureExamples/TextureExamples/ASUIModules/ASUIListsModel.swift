//
//  ASUIListsModel.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import Foundation
import ObjectMapper

enum ASUIListsSectionType {
    case ui
    case table
}

enum ASUIListsControlType {
    case image
    case networkImage
    case text
    case button
    case map
    case editableText
    case multiplexImage
    case pager
    case video
    case scroll
}

enum ASUITableNodeType {
    case kitten
}

// MARK: - ASUIListsSectionModel
struct ASUIListsSectionModel {
    var title: String?
    var type: ASUIListsSectionType?
    var items: [ASUIListsModel]?
}

extension ASUIListsSectionModel: Mappable {
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        items <- map["ASUIListsModel"]
    }
}

// MARK: - ASUIListsModel
struct ASUIListsModel {
    var title: String?
    var type: ASUIListsControlType?
    var tableType: ASUITableNodeType?
}

extension ASUIListsModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        tableType <- map["tableType"]
    }
}
