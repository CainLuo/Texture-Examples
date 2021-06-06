//
//  ParseResponse.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import Foundation

func parsePopularPage(withURL: URL, page: Int) -> Resource<PopularPageModel> {
    let parse = Resource<PopularPageModel>(url: withURL, page: page) { metaData, jsonData in
        do {
            let photos = try JSONDecoder().decode([PhotoModel].self, from: jsonData)
            return .success(PopularPageModel(metaData: metaData, photos: photos))
        } catch {
            return .failure(.errorParsingJSON)
        }
    }

    return parse
}
