//
//  PhotoListController.swift
//  TextureDemo
//
//  Created by CainLuo on 2021/6/6.
//

import AsyncDisplayKit

class PhotoListController: ASDKViewController<ASTableNode> {
    
    var photoFeedModel = PhotoFeedModel(photoFeedModelType: .photoFeedModelTypePopular)

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .gray)
    }()

    override init() {
        super.init(node: ASTableNode())
        
        navigationItem.title = "ASDK"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 是否允许点击
        self.node.allowsSelection = false
        // 设置数据源
        self.node.dataSource = self
        // 设置代理
        self.node.delegate = self
//        self.node.leadingScreensForBatching = 2.5
        self.node.view.separatorStyle = .none
                
        node.view.addSubview(activityIndicatorView)
    }
    
    // 数据网络请求
    func fetchNewBatchWithContext(_ context: ASBatchContext?) {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }

        photoFeedModel.updateNewBatchOfPopularPhotos() { additions, connectionStatus in
            switch connectionStatus {
            case .connected:
                self.activityIndicatorView.stopAnimating()
                self.addRowsIntoTableNode(newPhotoCount: additions)
                context?.completeBatchFetching(true)
            case .noConnection:
                self.activityIndicatorView.stopAnimating()
                context?.completeBatchFetching(true)
            }
        }
    }
    
    // TableNode插入ASCellNode
    func addRowsIntoTableNode(newPhotoCount newPhotos: Int) {
        let indexRange = (photoFeedModel.numberOfItems - newPhotos ..< photoFeedModel.numberOfItems)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
        node.insertRows(at: indexPaths, with: .none)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("AAAAAAAAA")
        // Center the activity indicator view
        let bounds = node.bounds
        activityIndicatorView.frame.origin = CGPoint(
            x: (bounds.width - activityIndicatorView.frame.width) / 2.0,
            y: (bounds.height - activityIndicatorView.frame.height) / 2.0
        )
    }
}

// MARK: - ASTableDataSource
extension PhotoListController: ASTableDataSource {
    // 返回TableNode的Section数量
    func numberOfSections(in tableNode: ASTableNode) -> Int {
       1
    }
    
    // 返回TableNode的ASCellNode数量
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        photoFeedModel.numberOfItems
    }

    // 返回给TableNode指定的ASCellNode
    func tableView(_ tableView: ASTableView, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let photo = photoFeedModel.itemAtIndexPath(indexPath)
        let cellNodeBlock: ASCellNodeBlock = {
            PhotoListNodeCell(photoModel: photo)
        }
        
        return cellNodeBlock
    }
}

// MARK: - ASTableDelegate
extension PhotoListController: ASTableDelegate {
    
    // 告诉TableNode是否开始批量获取
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        true
    }
    
    // 如果数据快到底部了，TableNode则会调用该方法，然后继续请求下一页
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    }
    
    // 指定Node的最大最小Size的范围
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        ASSizeRange(min: CGSize(width: tableNode.view.frame.size.width, height: 100),
                    max: CGSize(width: tableNode.view.frame.size.width, height: 300))
    }
}
