//
//  PhotoIGSectionsModel.swift
//  PhotoIGSectionsModel
//
//  Created by YYKJ0048 on 2021/8/25.
//

import Foundation
import IGListKit
import ObjectMapper

enum PhotoIGSectionType: Int {
    case photos
}

class PhotoIGSectionsModel: NSObject {
    
    var type: PhotoIGSectionType = .photos
    var photos: [PhotoTableModel] = []
    
    init(type: PhotoIGSectionType = .photos) {
        self.type = type
    }
}
