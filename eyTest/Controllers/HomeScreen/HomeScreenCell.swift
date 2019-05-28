//
//  HomeScreenCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class HomeScreenCell: BaseCollectionViewCell {
    
    let thumbailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let footerBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbailImageView)
        thumbailImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailling: contentView.trailingAnchor)
        
        addSubview(footerBar)
        footerBar.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailling: contentView.trailingAnchor, size: .init(width: 0, height: contentView.frame.height / 3))
        
        footerBar.addSubview(titleLabel)
        titleLabel.fillSuperView()
    }
}
