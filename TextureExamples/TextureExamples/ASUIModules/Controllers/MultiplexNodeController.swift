//
//  MultiplexNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/12.
//

import AsyncDisplayKit
import TextureSwiftSupport

class MultiplexNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension MultiplexNodeController {
    private func configBackgroundNode() {
        let contentNode = MultiplexContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: contentNode)
        }
    }
}

// MARK: - MultiplexContentNode
enum MultiplexImageType: NSString {
    case best
    case medium
    case worst
}

class MultiplexContentNode: ASDisplayNode {

    lazy var imageNode1: ASMultiplexImageNode = {
        let node = ASMultiplexImageNode(cache: nil, downloader: self)
        return node
    }()

    let reloadButtonNode = ASButtonNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        imageNode1.delegate = self
        imageNode1.dataSource = self
        imageNode1.backgroundColor = ASDisplayNodeDefaultPlaceholderColor()
        imageNode1.downloadsIntermediateImages = true
        reloadButtonNode.addTarget(self, action: #selector(reloadAction), forControlEvents: .touchUpInside)
        reloadAction()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            VStackLayout(spacing: 10) {
                imageNode1
                    .preferredSize(CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width))
                reloadButtonNode
                    .preferredSize(CGSize(width: constrainedSize.max.width, height: 44))
            }
        }
    }

    @objc func reloadAction() {
        reloadButtonNode.setTitle("Loading...", with: nil, with: nil, for: .normal)
        reloadButtonNode.isUserInteractionEnabled = false
        imageNode1.imageIdentifiers = [MultiplexImageType.best.rawValue,
                                       MultiplexImageType.medium.rawValue,
                                       MultiplexImageType.worst.rawValue]
        imageNode1.reloadImageIdentifierSources()
    }
}

// MARK: - ASMultiplexImageNodeDataSource
extension MultiplexContentNode: ASMultiplexImageNodeDataSource {
    func multiplexImageNode(_ imageNode: ASMultiplexImageNode, urlForImageIdentifier imageIdentifier: ASImageIdentifier) -> URL? {
        guard let identifier = imageIdentifier as? NSString else {
            return nil
        }

        let imageInfos = [
            MultiplexImageType.worst.rawValue: "https://raw.githubusercontent.com/facebook/AsyncDisplayKit/master/examples_extra/Multiplex/worst.png",
            MultiplexImageType.best.rawValue: "https://raw.githubusercontent.com/facebook/AsyncDisplayKit/master/examples_extra/Multiplex/best.png",
            MultiplexImageType.medium.rawValue: "https://raw.githubusercontent.com/facebook/AsyncDisplayKit/master/examples_extra/Multiplex/medium.png"
        ]

        return URL(string: imageInfos[identifier] ?? "")
    }
}

// MARK: - ASMultiplexImageNodeDelegate
extension MultiplexContentNode: ASMultiplexImageNodeDelegate {

    func multiplexImageNode(_ imageNode: ASMultiplexImageNode, didFinishDownloadingImageWithIdentifier imageIdentifier: ASImageIdentifier, error: Error?) {
        reloadButtonNode.setTitle("Loaded \(imageIdentifier)", with: nil, with: nil, for: .normal)
        guard let identifier = imageIdentifier as? NSString else {
            return
        }

        if identifier == MultiplexImageType.best.rawValue {
            reloadButtonNode.isUserInteractionEnabled = true
            reloadButtonNode.setTitle("Reload", with: nil, with: nil, for: .normal)
        }
    }
}

// MARK: - ASImageDownloaderProtocol
extension MultiplexContentNode: ASImageDownloaderProtocol {
    func downloadImage(with URL: URL, callbackQueue: DispatchQueue, downloadProgress: ASImageDownloaderProgress?,
                       completion: @escaping ASImageDownloaderCompletion) -> Any? {
        nil
    }

    func cancelImageDownload(forIdentifier downloadIdentifier: Any) {
        // Cancel image download
    }

    func downloadImage(with URL: URL, priority: ASImageDownloaderPriority, callbackQueue: DispatchQueue,
                       downloadProgress: ASImageDownloaderProgress?, completion: @escaping ASImageDownloaderCompletion) -> Any? {

        let request = URLRequest(url: URL)
        let task = URLSession.shared.downloadTask(with: request) { url, response, error in
            usleep(useconds_t(UInt64(1.0) * USEC_PER_SEC))
            if let url = url,
               let data = try? Data(contentsOf: url) {
                completion(UIImage(data: data), error, nil, nil)
            }
        }
        task.resume()
        return nil
    }
}
