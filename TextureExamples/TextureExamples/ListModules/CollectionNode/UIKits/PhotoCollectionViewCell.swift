//
//  PhotoCollectionViewCell.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    private lazy var photoImageView: NetworkImageView = {
        let imageView = NetworkImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var avatarImageView: NetworkImageView = {
        let imageView = NetworkImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20 / 2
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(0x000000, alpha: 0.3)
        return view
    }()

    func configItem(_ item: PhotoTableModel) {
        configUIs()
        photoImageView.loadImageUsingUrlString(urlString: item.urls?.regular ?? "")
        avatarImageView.loadImageUsingUrlString(urlString: item.user?.profileImage?.medium ?? "")
        usernameLabel.text = item.user?.name
    }

    func configUIs() {
        addSubview(photoImageView)
        addSubview(bgView)
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        layer.masksToBounds = true

        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalTo(5)
            make.bottom.equalTo(-5)
        }

        usernameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(5)
            make.right.equalTo(-5)
            make.centerY.equalTo(avatarImageView)
        }
    }
}
