//
//  PhotoTableNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/5.
//

import AsyncDisplayKit

class PhotoTableNodeController: ASDKViewController<ASTableNode> {

    override init() {
        super.init(node: ASTableNode())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.allowsSelection = false
    }
}

// MARK: - ASTableDataSource
extension PhotoTableNodeController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        0
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cell: ASCellNodeBlock = {
            ASCellNode()
        }
        return cell
    }
}
