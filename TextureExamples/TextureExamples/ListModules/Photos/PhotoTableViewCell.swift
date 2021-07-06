//
//  PhotoTableViewCell.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/6.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class NetworkImageView: UIImageView {

    var imageUrlString: String?

    func loadImageUsingUrlString(urlString: String) {

        imageUrlString = urlString

        let url = URL(string: urlString)

        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in

            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
        }).resume()
    }
}

class PhotoTableViewCell: UITableViewCell {

    func configItem(_ item: PhotoTableModel) {
        photoImageView.loadImageUsingUrlString(urlString: item.urls?.regular ?? "")
        avatarImageView.loadImageUsingUrlString(urlString: item.user?.profileImage?.medium ?? "")
        photoLikesLabel.attributedText = item.attributedStringLikes(withSize: Constants.CellLayout.FontSize)
        usernameLabel.attributedText = item.attributedStringForUserName(withSize: Constants.CellLayout.FontSize)
        timeIntervalLabel.attributedText = item.attributedStringForTimeSinceString(withSize: Constants.CellLayout.FontSize)
        photoDescriptionLabel.attributedText = item.attributedStringForDescription(withSize: Constants.CellLayout.FontSize)
        photoDescriptionLabel.sizeToFit()
        var rect = photoDescriptionLabel.frame
        let availableWidth = self.bounds.size.width - Constants.CellLayout.HorizontalBuffer * 2
        let attributed = item.attributedStringForDescription(withSize: Constants.CellLayout.FontSize)
        let availableSize = CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude)
        rect.size = attributed.boundingRect(with: availableSize, options: .usesLineFragmentOrigin, context: nil).size
        photoDescriptionLabel.frame = rect
    }

    let photoImageView: NetworkImageView = {
        let imageView = NetworkImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let avatarImageView: NetworkImageView = {
        let imageView = NetworkImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.CellLayout.UserImageHeight / 2
        imageView.clipsToBounds = true
        return imageView
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timeIntervalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let photoLikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let photoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(photoImageView)
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(timeIntervalLabel)
        addSubview(photoLikesLabel)
        addSubview(photoDescriptionLabel)
        setupConstraints()
    }

    func setupConstraints() {

        NSLayoutConstraint.activate ([
            //photoImageView
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.CellLayout.HeaderHeight),
            photoImageView.widthAnchor.constraint(equalTo: widthAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            // avatarImageView
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.CellLayout.HorizontalBuffer),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.CellLayout.HorizontalBuffer),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.CellLayout.UserImageHeight),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            // usernameLabel
            usernameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: Constants.CellLayout.HorizontalBuffer),
            usernameLabel.rightAnchor.constraint(equalTo: timeIntervalLabel.leftAnchor, constant: -Constants.CellLayout.HorizontalBuffer),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            // timeIntervalLabel
            timeIntervalLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.CellLayout.HorizontalBuffer),
            timeIntervalLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            // photoLikesLabel
            photoLikesLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: Constants.CellLayout.VerticalBuffer),
            photoLikesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.CellLayout.HorizontalBuffer),
            // photoDescriptionLabel
            photoDescriptionLabel.topAnchor.constraint(equalTo: photoLikesLabel.bottomAnchor, constant: Constants.CellLayout.VerticalBuffer),
            photoDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.CellLayout.HorizontalBuffer),
            photoDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.CellLayout.HorizontalBuffer),
            photoDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.CellLayout.VerticalBuffer)
            ])
    }

    class func height(for photo: PhotoTableModel, withWidth width: CGFloat) -> CGFloat {
        let photoHeight = width
        let font = UIFont.systemFont(ofSize: Constants.CellLayout.FontSize)
        let likesHeight = round(font.lineHeight)
        let descriptionAttrString = photo.attributedStringForDescription(withSize: Constants.CellLayout.FontSize)
        let availableWidth = width - Constants.CellLayout.HorizontalBuffer * 2
        let descriptionHeight = descriptionAttrString.boundingRect(with: CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size.height

        return likesHeight + descriptionHeight + photoHeight + Constants.CellLayout.HeaderHeight + Constants.CellLayout.VerticalBuffer * 3
    }
}
