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

        avatarNode.url = URL(string: item.avatar ?? "")
        addSubnode(avatarNode)

        likeButtonNode.backgroundColor = .cyan

        muteButtonNode.setImage(#imageLiteral(resourceName: "videoUnmuteute"), for: .normal)
        muteButtonNode.style.preferredSize = CGSize(width: 16, height: 20)
        muteButtonNode.addTarget(self, action: #selector(tapMuteAction), forControlEvents: .touchUpInside)

        videoNode = ASVideoPlayerNode(url: URL(string: item.url ?? "")!)
        videoNode?.delegate = self
        videoNode?.backgroundColor = .black
        videoNode?.shouldAutoRepeat = true
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
        node.setImage(videoNode?.muted == true ? #imageLiteral(resourceName: "videoMute") : #imageLiteral(resourceName: "videoUnmuteute"), for: .normal)
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
extension RabbitVideosCellNode {
    func videoPlayerNodeLayoutSpec(_ videoPlayer: ASVideoPlayerNode,
                                   forControls controls: [AnyHashable : Any],
                                   forMaximumSize maxSize: CGSize) -> ASLayoutSpec {

        let topControl = getCustomControls(controls, maxSize: maxSize)
        let bottomControl = getDefaultControls(controls, maxSize: maxSize)
        guard !bottomControl.isEmpty else {
            return ASLayoutSpec()
        }

        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        return LayoutSpec {
            VStackLayout {
                InsetLayout(insets: insets) {
                    HStackLayout(spacing: 10, justifyContent: .start, alignItems: .center) {
                        topControl
                    }
                }
                SpacerLayout(minLength: 10, flexGrow: 1.0)
                InsetLayout(insets: insets) {
                    HStackLayout(spacing: 10, justifyContent: .start, alignItems: .center) {
                        bottomControl
                    }
                }
            }
        }
    }
    
    /// Get ASVideoPlayerNode custom controls
    /// - Parameters:
    ///   - controllBar: [AnyHashable: Any]
    ///   - maxSize: CGSize
    /// - Returns: [ASDisplayNode]
    private func getCustomControls(_ controls: [AnyHashable: Any], maxSize: CGSize) -> [ASDisplayNode] {
        var array: [ASButtonNode] = []

        if let mute = controls["muteControl"] as? ASButtonNode {
            mute.style.preferredSize = CGSize(width: 29, height: 20)
            array.append(mute)
        }
        return array
    }
    
    /// Get ASVideoPlayerNode default controls
    /// - Parameters:
    ///   - controllBar: [AnyHashable: Any]
    ///   - maxSize: CGSize
    /// - Returns: [ASDisplayNode]
    private func getDefaultControls(_ controls: [AnyHashable: Any], maxSize: CGSize) -> [ASDisplayNode] {
        var array: [ASDisplayNode] = []

        if let playbackButton = controls[ASVideoPlayerNodeControlType.playbackButton.rawValue] as? ASControlNode {
            array.append(playbackButton)
        }
        
        if let elapsedText = controls[ASVideoPlayerNodeControlType.elapsedText.rawValue] as? ASTextNode {
            array.append(elapsedText)
        }

        if let scrubber = controls[ASVideoPlayerNodeControlType.scrubber.rawValue] as? ASDisplayNode {
            scrubber.style.height = ASDimensionMake(44.0)
            scrubber.style.minWidth = ASDimensionMake(0.0)
            scrubber.style.maxWidth = ASDimensionMake(maxSize.width)
            scrubber.style.flexGrow = 1.0
            array.append(scrubber)
        }

        if let durationText = controls[ASVideoPlayerNodeControlType.durationText.rawValue] as? ASTextNode {
            array.append(durationText)
        }

        return array
    }
}
