//
//  PhotoModel.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/7/5.
//

import Foundation
import ObjectMapper

struct PhotoTableSubmitModel {
    var order_by: String = "popular"
    var client_id: String = "3b99a69cee09770a4a0bbb870b437dbda53efb22f6f6de63714b71c4df7c9642"
    var page: String = "0"
}

extension PhotoTableSubmitModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        order_by <- map["order_by"]
        client_id <- map["client_id"]
        page <- map["page"]
    }
}

// MARK: - PhotoTableModel
struct PhotoTableModel {
    var altDescription: String?
    var blurHash: String?
    var categories: [AnyObject]?
    var color: String?
    var createdAt: String?
    var currentUserCollections: [AnyObject]?
    var descriptionField: String?
    var height: Int?
    var id: String?
    var likedByUser: Bool?
    var likes: Int?
    var links: PhotoTableLink?
    var promotedAt: String?
    var sponsorship: AnyObject?
    var updatedAt: String?
    var urls: PhotoTableUrl?
    var user: PhotoTableUser?
    var width: Int?
}

extension PhotoTableModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        altDescription <- map["alt_description"]
        blurHash <- map["blur_hash"]
        categories <- map["categories"]
        color <- map["color"]
        createdAt <- map["created_at"]
        currentUserCollections <- map["current_user_collections"]
        descriptionField <- map["description"]
        height <- map["height"]
        id <- map["id"]
        likedByUser <- map["liked_by_user"]
        likes <- map["likes"]
        links <- map["links"]
        promotedAt <- map["promoted_at"]
        sponsorship <- map["sponsorship"]
        updatedAt <- map["updated_at"]
        urls <- map["urls"]
        user <- map["user"]
        width <- map["width"]
    }
}

// MARK: - PhotoTableUser
struct PhotoTableUser {
    var acceptedTos: Bool?
    var bio: String?
    var firstName: String?
    var forHire: Bool?
    var id: String?
    var instagramUsername: String?
    var lastName: String?
    var links: PhotoTableLink?
    var location: String?
    var name: String?
    var portfolioUrl: String?
    var profileImage: PhotoTableProfileImage?
    var social: PhotoTableSocial?
    var totalCollections: Int?
    var totalLikes: Int?
    var totalPhotos: Int?
    var twitterUsername: String?
    var updatedAt: String?
    var username: String?
}

extension PhotoTableUser: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        acceptedTos <- map["accepted_tos"]
        bio <- map["bio"]
        firstName <- map["first_name"]
        forHire <- map["for_hire"]
        id <- map["id"]
        instagramUsername <- map["instagram_username"]
        lastName <- map["last_name"]
        links <- map["links"]
        location <- map["location"]
        name <- map["name"]
        portfolioUrl <- map["portfolio_url"]
        profileImage <- map["profile_image"]
        social <- map["social"]
        totalCollections <- map["total_collections"]
        totalLikes <- map["total_likes"]
        totalPhotos <- map["total_photos"]
        twitterUsername <- map["twitter_username"]
        updatedAt <- map["updated_at"]
        username <- map["username"]
    }
}

// MARK: - PhotoTableSocial
struct PhotoTableSocial {
    var instagramUsername: String?
    var portfolioUrl: String?
    var twitterUsername: String?
}

extension PhotoTableSocial: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        instagramUsername <- map["instagram_username"]
        portfolioUrl <- map["portfolio_url"]
        twitterUsername <- map["twitter_username"]
    }
}

// MARK: - PhotoTableProfileImage
struct PhotoTableProfileImage {
    var large: String?
    var medium: String?
    var small: String?
}

extension PhotoTableProfileImage: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        large <- map["large"]
        medium <- map["medium"]
        small <- map["small"]
    }
}

// MARL: - PhotoTableUrl
struct PhotoTableUrl {
    var full: String?
    var raw: String?
    var regular: String?
    var small: String?
    var thumb: String?
}

extension PhotoTableUrl: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        full <- map["full"]
        raw <- map["raw"]
        regular <- map["regular"]
        small <- map["small"]
        thumb <- map["thumb"]
    }
}

// MARK: - PhotoTableLink
struct PhotoTableLink {
    var download: String?
    var downloadLocation: String?
    var html: String?
    var `self`: String?
    var followers: String?
    var following: String?
    var likes: String?
    var photos: String?
    var portfolio: String?
}

extension PhotoTableLink: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        download <- map["download"]
        downloadLocation <- map["download_location"]
        html <- map["html"]
        `self` <- map["self"]
        followers <- map["followers"]
        following <- map["following"]
        likes <- map["likes"]
        photos <- map["photos"]
        portfolio <- map["portfolio"]
    }
}
