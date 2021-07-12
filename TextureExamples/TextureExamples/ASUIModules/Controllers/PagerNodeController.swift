//
//  PagerNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/12.
//

import UIKit
import AsyncDisplayKit

class PagerNodeController: BasePagerNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        node.setDataSource(self)
        node.setDelegate(self)
        configItems()
    }

    private func configItems() {
        let next = UIBarButtonItem(title: "PagerNode_Next".localized(), style: .plain, target: self, action: #selector(scrollToNextPager))
        let provious = UIBarButtonItem(title: "PagerNode_Previous".localized(), style: .plain, target: self, action: #selector(scrollToPreviousPager))
        navigationItem.rightBarButtonItems = [next, provious]
    }

    @objc func scrollToNextPager() {
        node.scrollToPage(at: node.currentPageIndex + 1, animated: true)
    }

    @objc func scrollToPreviousPager() {
        node.scrollToPage(at: node.currentPageIndex - 1, animated: true)
    }
}

// MARK: - ASPagerDataSource
extension PagerNodeController: ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        Int(arc4random() % 999)
    }

    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        {
            PagerCellNode()
        }
    }
}

// MARK: - ASPagerDelegate
extension PagerNodeController: ASPagerDelegate {

}

// MARK: - PagerCellNode
class PagerCellNode: ASCellNode {

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = UIColor.randomColor
    }
}
