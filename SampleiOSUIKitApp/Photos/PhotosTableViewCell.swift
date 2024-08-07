//
//  PhotosTableViewCell.swift
//  SampleiOSUIKitApp
//
//  Created by Arshad Khan on 8/7/24.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let albumIdLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let contentHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let textVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePhotoCell(_ photo: PhotoModel) {
        titleLabel.text = photo.title
        albumIdLabel.text = "\(photo.albumId)"
        if let thumbnailString = photo.thumbnailUrl {
           ImageLoader().getImage(from: thumbnailString) { [weak self] image in
               DispatchQueue.main.async {
                   self?.thumbnailImageView.image = image
               }
            }
        }
    }
    
    private func setupViews() {
        textVStackView.addArrangedSubview(titleLabel)
        textVStackView.addArrangedSubview(albumIdLabel)
        
        contentHStackView.addArrangedSubview(thumbnailImageView)
        contentHStackView.addArrangedSubview(textVStackView)
        addSubview(contentHStackView)
    }
    
    private func setupConstraints() {
        contentHStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentHStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentHStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentHStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
