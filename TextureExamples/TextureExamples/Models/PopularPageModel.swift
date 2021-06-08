//
//  PopularPageModel.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import Foundation

struct PopularPageModel {
    let page: Int
    let totalPages: Int
    let totalNumberOfItems: Int
    let photos: [PhotoModel]
    
    init(metaData: ResponseMetadata, photos:[PhotoModel]) {
        self.page = metaData.currentPage
        self.totalPages = metaData.pagesTotal
        self.totalNumberOfItems = metaData.itemsTotal
        self.photos = photos
    }
}
