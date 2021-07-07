//
//  BaseNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

class BaseNodeController: ASDKViewController<ASDisplayNode> {

    let disposeBag = DisposeBag()

    override init() {
        super.init(node: ASDisplayNode())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
