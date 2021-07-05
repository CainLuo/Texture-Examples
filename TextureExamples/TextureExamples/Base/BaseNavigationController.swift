//
//  BaseNavigationController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/5.
//

import AsyncDisplayKit

class BaseNavigationController: ASNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension BaseNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let vc = navigationController.viewControllers.first else {
            return
        }
        viewController.hidesBottomBarWhenPushed = !viewController.isEqual(vc)
    }
}
