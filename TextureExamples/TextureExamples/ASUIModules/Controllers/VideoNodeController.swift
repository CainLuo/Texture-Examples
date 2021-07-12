//
//  VideoNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/12.
//

import UIKit
import AsyncDisplayKit
import TextureSwiftSupport

class VideoNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension VideoNodeController {
    private func configBackgroundNode() {
        let contentNode = VideoContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: contentNode)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: centerSpec)
        }
    }
}

// MARK: - VideoContentNode
class VideoContentNode: ASDisplayNode {

    private lazy var videoNode1: ASVideoNode = {
        let node = ASVideoNode()
        node.backgroundColor = .lightGray
        node.periodicTimeObserverTimescale = 1
        return node
    }()

    private lazy var videoNode2: ASVideoNode = {
        let node = ASVideoNode()
        node.asset = AVAsset(url: URL(string: "https://cl.ly/3X3N361x2h1V/Screen%20Recording%202017-02-06%20at%2002.53%20PM.mov")!)
        node.backgroundColor = .red
        node.shouldAutoplay = true
        node.shouldAutorepeat = true
        node.muted = true
        node.url = URL(string: "https://upload.wikimedia.org/wikipedia/en/5/52/Testcard_F.jpg")
        return node
    }()

    private lazy var videoNode3: ASVideoNode = {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "simon", ofType: "mp4") ?? "")
        let node = ASVideoNode()
        node.asset = AVAsset(url: url)
        node.gravity = AVLayerVideoGravity.resizeAspect.rawValue
        node.backgroundColor = .lightGray
        node.shouldAutoplay = true
        node.shouldAutorepeat = true
        return node
    }()

    private lazy var videoNode4: ASVideoNode = {
        let node = ASVideoNode()
        node.asset = AVAsset(url: URL(string: "https://media.w3.org/2010/05/sintel/trailer.mp4")!)
        node.gravity = AVLayerVideoGravity.resize.rawValue
        node.backgroundColor = .lightGray
        node.shouldAutoplay = true
        node.shouldAutorepeat = true
        node.muted = true
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.videoNode1.asset = AVAsset(url: URL(string: "http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8")!)
            self?.videoNode1.play()
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            VStackLayout(spacing: 10) {
                videoNode1
                    .preferredSize(CGSize(width: constrainedSize.max.width, height: 100))
                videoNode2
                    .preferredSize(CGSize(width: constrainedSize.max.width, height: 100))
                videoNode3
                    .preferredSize(CGSize(width: constrainedSize.max.width, height: 100))
                videoNode4
                    .preferredSize(CGSize(width: constrainedSize.max.width, height: 100))
            }
        }
    }
}
