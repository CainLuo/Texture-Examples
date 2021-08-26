//
//  TabBarModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/29.
//

import Foundation
import ObjectMapper

struct TabBarModel {
    var title: String?
    var icon: UIImage?
    var selectIcon: UIImage?
    var controller: UIViewController?
}

extension TabBarModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        icon <- map["icon"]
        selectIcon <- map["selectIcon"]
        controller <- map["controller"]
    }
}
