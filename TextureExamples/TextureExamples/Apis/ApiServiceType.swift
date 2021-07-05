//
//  ApiServiceType.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/4/26.
//  Copyright © 2020 ve2. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import RxSwift

protocol ApiServiceType {
    // MARK: Photos
    func getPhotos(_ model: PhotoTableSubmitModel) -> Single<[PhotoTableModel]>
}
