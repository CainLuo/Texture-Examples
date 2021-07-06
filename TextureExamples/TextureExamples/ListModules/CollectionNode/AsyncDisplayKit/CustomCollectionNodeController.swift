//
//  CustomCollectionNodeController.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import AsyncDisplayKit

class CustomCollectionNodeController: BaseCollectionNodeController {
    
    lazy var collectionNode: ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 50, height: 50)
        layout.footerReferenceSize = CGSize(width: 50, height: 50)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 2 - 10, height: 50)
        let collectionNode = ASCollectionNode(collectionViewLayout: layout)
        collectionNode.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionNode.backgroundColor = .white
        collectionNode.frame = self.view.bounds
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionFooter)
        return collectionNode
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubnode(collectionNode)
        collectionNode.reloadData()
        configLeftItems()
        title = "CustomCollectionNode"
    }
    
    private func configLeftItems() {
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "未读数(1)", style: .plain, target: self, action: nil)
    }
}

// MARK: - ASCollectionDataSource
extension CustomCollectionNodeController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        100
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        Int(arc4random_uniform(20))
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock: ASCellNodeBlock = {
            let cell = CustomCollectionCellNode(indexPath.row)
            cell.backgroundColor = indexPath.row % 2 == 0 ? .purple : .brown
            return cell
        }
        
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        let isHeader = kind == UICollectionView.elementKindSectionHeader
        let node = ASCellNode()
        node.backgroundColor = isHeader ? .blue : .red
        return node
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, canMoveItemWith node: ASCellNode) -> Bool {
        true
    }
}

// MARK: - ASCollectionDelegate
extension CustomCollectionNodeController: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        
    }
}
