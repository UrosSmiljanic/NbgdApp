//
//  ReletedNewsCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 18/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class RelatedNewsCell: BaseCollectionViewCell {
    
    let thumbail: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let publishDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        
        return label
    }()
    
    let publishTime: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        
        return label
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        
        return label
    }()
    
    let calThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "calendar")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let timeThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "clock")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()
    
    let blackSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(yellowView)
        yellowView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailling: contentView.trailingAnchor, size: .init(width: 0, height: 5))
        
        addSubview(thumbail)
        thumbail.anchor(top: yellowView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailling: nil, size: .init(width: 150, height: 100))
        
        addSubview(title)
        title.anchor(top: yellowView.bottomAnchor, leading: thumbail.trailingAnchor, bottom: nil, trailling: contentView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 0, height: 60))
        
        addSubview(blackSeparator)
        blackSeparator.anchor(top: title.bottomAnchor, leading: thumbail.trailingAnchor, bottom: nil, trailling: contentView.trailingAnchor, size: .init(width: 0, height: 1))
        
        addSubview(calThumbail)
        calThumbail.anchor(top: blackSeparator.bottomAnchor, leading: thumbail.trailingAnchor, bottom: contentView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        
        addSubview(publishDate)
        publishDate.anchor(top: blackSeparator.bottomAnchor, leading: calThumbail.trailingAnchor, bottom: contentView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))
        
        addSubview(timeThumbail)
        timeThumbail.anchor(top: blackSeparator.bottomAnchor, leading: publishDate.trailingAnchor, bottom: contentView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        
        addSubview(publishTime)
        publishTime.anchor(top: blackSeparator.bottomAnchor, leading: timeThumbail.trailingAnchor, bottom: contentView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))
        
    }
}

