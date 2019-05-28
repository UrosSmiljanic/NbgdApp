//
//  CalendarCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 05/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class CalendarCell: BaseCollectionViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(hexString: "DFDFDF")
        return view
    }()

    let monthTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
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


        cellView.addSubview(monthTitle)
        monthTitle.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: cellView.bottomAnchor, trailling: cellView.trailingAnchor, padding: .init(top: 4, left: 4, bottom: 4, right: 4))
    }
    
}
