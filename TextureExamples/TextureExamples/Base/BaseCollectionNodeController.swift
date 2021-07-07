//
//  BaseCollectionNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

class BaseCollectionNodeController: ASDKViewController<ASCollectionNode> {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        emptyBackBarButtonItem()
        log.debug(self.className)
    }

    deinit {
        log.debug(self.className)
    }
}
