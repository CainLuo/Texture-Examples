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
    case transition
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
    case asTransition
    case customTransition
}

enum ASUITableNodeType {
    case kitten
    case rabbit
    case ninePattern
    case gifList
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
    var images: [String] = []
}

extension ASUIListsModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        tableType <- map["tableType"]
        images <- map["images"]
    }
}
