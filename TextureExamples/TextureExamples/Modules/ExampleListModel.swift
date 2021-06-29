//
//  ExampleListModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import Foundation
import ObjectMapper

struct ExampleListModel {
    var title: String?
}

extension ExampleListModel: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["title"]
    }
}
