//
//  BaseTableNodeController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

class BaseTableNodeController: ASDKViewController<ASTableNode> {
    
    let disposeBag = DisposeBag()

    override init() {
        super.init(node: ASTableNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        emptyBackBarButtonItem()
    }
}
