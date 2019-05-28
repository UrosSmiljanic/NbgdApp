//
//  SearchScreenCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 11/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class SearchScreenCell: UITableViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = UIColor(hexString: "323334")
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "FEE433")
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(cellView)
        cellView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailling: trailingAnchor, size: .init(width: 0, height: 80))

        cellView.addSubview(titleLabel)
        titleLabel.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: nil, trailling: cellView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 20))

        cellView.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, leading: cellView.leadingAnchor, bottom: nil, trailling: cellView.trailingAnchor, padding: .init(top: 4, left: 12, bottom: 12, right: 12))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
