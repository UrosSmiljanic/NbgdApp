//
//  GridIconModelCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 14/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class GridIconModelCell: BaseCollectionViewCell {
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let footerView: UIView = {
        let view = UIView()
       view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
       label.numberOfLines = 2
        label.font = UIFont(name: "EYInterstate-Bold", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor(hexString: "555555")
        
        addSubview(footerView)
        footerView.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailling: contentView.trailingAnchor, size: .init(width: 0, height: contentView.frame.height / 3))
        
        footerView.addSubview(titleLabel)
        titleLabel.fillSuperView()
        
        addSubview(iconImageView)
        iconImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: footerView.topAnchor, trailling: contentView.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 32, right: 32))
        
        
    }
}
