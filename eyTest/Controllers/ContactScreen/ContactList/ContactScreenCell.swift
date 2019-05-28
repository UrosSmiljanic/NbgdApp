//
//  ContactScreenCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 14/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class ContactScreenCell: BaseCollectionViewCell {
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()
    
    let profileImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
       
        backgroundColor = UIColor.groupTableViewBackground
        
        addSubview(yellowView)
        yellowView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailling: nil, size: .init(width: 10, height: 0))
        
        addSubview(profileImageView)
        profileImageView.anchor(top: contentView.topAnchor, leading: yellowView.trailingAnchor, bottom: contentView.bottomAnchor, trailling: nil, size: .init(width: 100, height: 100))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: contentView.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: contentView.frame.height / 2))
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: contentView.bottomAnchor, trailling: contentView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
    }
}
