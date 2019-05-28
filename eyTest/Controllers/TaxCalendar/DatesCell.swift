//
//  DatesCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 11/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class DatesCell: BaseCollectionViewCell {

    let dateView: UIButton = {
        let button = UIButton()
        button.setTitle("EUR", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 30)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        button.isUserInteractionEnabled = false

        return button
    }()

    override func setupViews() {
        super.setupViews()

        addSubview(dateView)
        dateView.fillSuperView()

    }
    
}
