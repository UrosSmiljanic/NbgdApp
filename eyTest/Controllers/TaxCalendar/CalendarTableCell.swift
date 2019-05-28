//
//  CalendarTableCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 11/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class CalendarTableCell: UITableViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = UIColor(hexString: "DFDFDF")
        return view
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.textAlignment = .left

        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75

        return label
    }()

    let viewThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "view")
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(cellView)
        cellView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailling: trailingAnchor, size: .init(width: 0, height: 80))

        cellView.addSubview(viewThumbail)
        viewThumbail.anchor(top: cellView.topAnchor, leading: nil, bottom: nil, trailling: cellView.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 4), size: .init(width: 30, height: 30))

        cellView.addSubview(dateLabel)
        dateLabel.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: viewThumbail.bottomAnchor, trailling: viewThumbail.leadingAnchor, padding: .init(top: 4, left: 12, bottom: 0, right: 12))

        cellView.addSubview(titleLabel)
        titleLabel.anchor(top: dateLabel.bottomAnchor, leading: cellView.leadingAnchor, bottom: cellView.bottomAnchor, trailling: cellView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 0))

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
