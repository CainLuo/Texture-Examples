//
//  BasePagerNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/12.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

class BasePagerNodeController: ASDKViewController<ASPagerNode> {

    let disposeBag = DisposeBag()

    override init() {
        super.init(node: ASPagerNode())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.automaticallyRelayoutOnSafeAreaChanges = true
        view.backgroundColor = .white
        emptyBackBarButtonItem()
        log.debug(self.className)
    }

    deinit {
        log.debug(self.className)
    }
}
