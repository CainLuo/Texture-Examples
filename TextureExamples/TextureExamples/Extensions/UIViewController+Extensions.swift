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

// MARK: Class Name
extension NSObject {
    class var className: String {
        String(describing: self)
    }

    var className: String {
        type(of: self).className
    }
}
