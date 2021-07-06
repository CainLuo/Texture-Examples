//
//  UIViewController+Extensions.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import UIKit

extension UIViewController {
    func emptyBackBarButtonItem() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
    }
}
