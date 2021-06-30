//
//  TabBarController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import AsyncDisplayKit

class TabBarController: ASTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = configControllers()
        tabBar.backgroundColor = .white
    }
}

extension TabBarController {
    private func configControllers() -> [UIViewController] {
        configModels().map { item -> ASNavigationController in
            let vc = item.controller!
            vc.title = item.title
            let nv = ASNavigationController(rootViewController: vc)
            nv.tabBarItem.image = item.icon
            nv.tabBarItem.selectedImage = item.selectIcon
            return nv
        }
    }
}

extension TabBarController {
    private func configModels() -> [TabBarModel] {
        [
            TabBarModel(title: "TabBar_Home", icon: #imageLiteral(resourceName: "tabBarStackContent"), selectIcon: #imageLiteral(resourceName: "tabBarStackContent"), controller: ExampleListController())
        ]
    }
}
