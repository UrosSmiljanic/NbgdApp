//
//  IndustriesToChoose.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 01/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class IndustriesToChoose: BaseCollectionViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(hexString: "DFDFDF")
        return view
    }()

    let checkMark: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "checkMark")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.isHidden = true
        return view
    }()

    let industryTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 15)
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    override func setupViews() {
        super.setupViews()
        addSubview(cellView)
        cellView.fillSuperView()

        cellView.addSubview(checkMark)
        checkMark.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 20, height: 20))

        cellView.addSubview(industryTitle)
        industryTitle.anchor(top: cellView.topAnchor, leading: checkMark.trailingAnchor, bottom: cellView.bottomAnchor, trailling: cellView.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 4, right: 4))
    }
    
}
