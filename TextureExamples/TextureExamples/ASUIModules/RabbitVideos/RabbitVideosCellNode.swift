//
//  RabbitVideosCellNode.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/13.
//

import UIKit
import AsyncDisplayKit
import TextureSwiftSupport

class RabbitVideosCellNode: ASCellNode {
    var titleNode = ASTextNode()
    var avatarNode = ASNetworkImageNode()
    var likeButtonNode = ASControlNode()
    var muteButtonNode = ASButtonNode()
    var videoNode: ASVideoPlayerNode?

    init(_ item: RabbitVideosModel) {
        super.init()
        automaticallyManagesSubnodes = true

        titleNode.style.flexGrow = 1.0
        titleNode.attributedText = NSAttributedString.attributed(item.title ?? "")
//        addSubnode(titleNode)

        avatarNode.url = URL(string: item.avatar ?? "")
        addSubnode(avatarNode)

        likeButtonNode.backgroundColor = .cyan
//        addSubnode(likeButtonNode)

        muteButtonNode.setImage(#imageLiteral(resourceName: "videoUnmuteute"), for: .normal)
        muteButtonNode.style.preferredSize = CGSize(width: 16, height: 20)
        muteButtonNode.addTarget(self, action: #selector(tapMuteAction), forControlEvents: .touchUpInside)

        videoNode = ASVideoPlayerNode(url: URL(string: item.url ?? "")!)
        videoNode?.delegate = self
        videoNode?.backgroundColor = .black
        videoNode?.shouldAutoRepeat = true
//        if let videoNode = videoNode {
//            addSubnode(videoNode)
//        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            VStackLayout(spacing: 10) {
                InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                    HStackLayout(spacing: 10) {
                        avatarNode
                            .preferredSize(CGSize(width: 44, height: 44))
                        titleNode
                    }
                }
                videoNode
                    .preferredSize(CGSize(width: constrainedSize.max.width,
                                          height: constrainedSize.max.width * 9 / 16))
                InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
                    HStackLayout(spacing: 10, alignItems: .center) {
                        likeButtonNode
                            .preferredSize(CGSize(width: 50, height: 26))
                    }
                }
            }
        }
    }

    @objc private func tapMuteAction(_ node: ASButtonNode) {
        videoNode?.muted = !(videoNode?.muted ?? false)
        node.setImage(videoNode?.muted == true ? #imageLiteral(resourceName: "videoMute") : #imageLiteral(resourceName: "videoMute"), for: .normal)
    }
}

// MARK: - ASVideoPlayerNodeDelegate
extension RabbitVideosCellNode: ASVideoPlayerNodeDelegate {
    func didTap(_ videoPlayer: ASVideoPlayerNode) {
        let isPlaying = videoNode?.playerState == .playing
        if isPlaying {
            videoNode?.controlsDisabled = !(videoNode?.controlsDisabled ?? false)
        }
        isPlaying ? videoNode?.pause() : videoNode?.play()
    }

    func videoPlayerNodeCustomControls(_ videoPlayer: ASVideoPlayerNode) -> [AnyHashable : Any] {
        ["muteControl": muteButtonNode]
    }
}

// MARK: - ASVideoPlayerNode Layout Spec
//extension RabbitVideosCellNode {
//    func videoPlayerNodeLayoutSpec(_ videoPlayer: ASVideoPlayerNode,
//                                   forControls controls: [AnyHashable : Any],
//                                   forMaximumSize maxSize: CGSize) -> ASLayoutSpec {
//
//        let bottomBarControl = getControls(controls)
//        guard !bottomBarControl.isEmpty else {
//            return ASLayoutSpec()
//        }
//
//        var topBarControl: [ASButtonNode] = []
//
//        if let mute = controls["muteControl"] as? ASButtonNode {
//            topBarControl.append(mute)
//        }
//
//        return LayoutSpec {
//            VStackLayout(spacing: 0, justifyContent: .start, alignItems: .start) {
////                InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
////                    HStackLayout(spacing: 10, justifyContent: .start, alignItems: .center) {
////                        topBarControl
////                    }
////                }
////                SpacerLayout(minLength: 10, flexGrow: 1.0)
//                InsetLayout(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) {
//                    HStackLayout(spacing: 10, justifyContent: .start, alignItems: .stretch) {
//                        bottomBarControl
//                    }
//                }
//            }
//        }
//    }
//
//
//    private func getControls(_ controllBar: [AnyHashable: Any]) -> [ASDisplayNode] {
//        var array: [ASDisplayNode] = []
//
//        controllBar.forEach { (_, value) in
//            if let node = value as? ASDisplayNode {
//                array.append(node)
//            }
//        }
//
//        return array
//    }
//}
