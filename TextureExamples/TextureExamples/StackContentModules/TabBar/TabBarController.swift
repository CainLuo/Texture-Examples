//
//  TabBarController.swift
//  TextureExamples
//
//  Created by CainLuo on 2021/6/28.
//

import Localize_Swift
import AsyncDisplayKit

class TabBarController: ASTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = configControllers()
        tabBar.backgroundColor = .white
        log.debug(self.className)
    }

    deinit {
        log.debug(self.className)
    }
}

extension TabBarController {
    private func configControllers() -> [UIViewController] {
        configModels().map { item -> BaseNavigationController in
            let vc = item.controller!
            vc.title = item.title
            let nv = BaseNavigationController(rootViewController: vc)
            nv.tabBarItem.image = item.icon
            nv.tabBarItem.selectedImage = item.selectIcon
            nv.navigationBar.isTranslucent = false
            return nv
        }
    }
}

extension TabBarController {
    private func configModels() -> [TabBarModel] {
        [
            TabBarModel(title: "TabBar_StackContent".localized(), icon: #imageLiteral(resourceName: "tabBarStackContent"), selectIcon: #imageLiteral(resourceName: "tabBarStackContent"), controller: ExampleListController()),
            TabBarModel(title: "TabBar_LayoutSpec".localized(), icon: #imageLiteral(resourceName: "tabBarLayoutSpec"), selectIcon: #imageLiteral(resourceName: "tabBarLayoutSpec"), controller: LayoutsController()),
            TabBarModel(title: "TabBar_List".localized(), icon: #imageLiteral(resourceName: "tabBarList"), selectIcon: #imageLiteral(resourceName: "tabBarList"), controller: ListsController()),
            TabBarModel(title: "TabBar_UI".localized(), icon: #imageLiteral(resourceName: "tabBarUIs"), selectIcon: #imageLiteral(resourceName: "tabBarUIs"), controller: ASUIListsController()),
            TabBarModel(title: "TabBar_Support".localized(), icon: #imageLiteral(resourceName: "tabBarSupport"), selectIcon: #imageLiteral(resourceName: "tabBarSupport"), controller: RootContainerViewController())
        ]
    }
}
