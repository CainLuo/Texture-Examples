//
//  URL.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import UIKit

extension URL {
    static func URLForFeedModelType(feedModelType: PhotoFeedModelType) -> URL {
        switch feedModelType {
        case .photoFeedModelTypePopular:
            return URL(string: assembleUnsplashURLString(endpoint: Constants.Unsplash.URLS.PopularEndpoint))!

        case .photoFeedModelTypeLocation:
            return URL(string: assembleUnsplashURLString(endpoint: Constants.Unsplash.URLS.SearchEndpoint))!

        case .photoFeedModelTypeUserPhotos:
            return URL(string: assembleUnsplashURLString(endpoint: Constants.Unsplash.URLS.UserEndpoint))!
        }
    }
    
    private static func assembleUnsplashURLString(endpoint: String) -> String {
        return Constants.Unsplash.URLS.Host + endpoint + Constants.Unsplash.URLS.ConsumerKey
    }
}
