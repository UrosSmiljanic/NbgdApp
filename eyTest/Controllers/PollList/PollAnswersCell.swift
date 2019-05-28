//
//  PollAnswersCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 07/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class PollAnswersCell: UITableViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "DFDFDF")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5

        return view
    }()

    let alphabetImage: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setBackgroundImage(#imageLiteral(resourceName: "whiteCircle"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(cellView)
        cellView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailling: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        cellView.addSubview(alphabetImage)
        alphabetImage.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: cellView.bottomAnchor, trailling: nil, padding: .init(top: 4, left: 4, bottom: 4, right: 0), size: .init(width: 50, height: 50))

        cellView.addSubview(answerLabel)
        answerLabel.anchor(top: cellView.topAnchor, leading: alphabetImage.trailingAnchor, bottom: cellView.bottomAnchor, trailling: cellView.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
