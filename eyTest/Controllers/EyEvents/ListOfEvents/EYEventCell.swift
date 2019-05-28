//
//  EYEventCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 04/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class EYEventCell: UITableViewCell {

    let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    let cellView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "DFDFDF").cgColor
        view.backgroundColor = UIColor(hexString: "323334")

        return view
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.textColor = UIColor(hexString: "FEE433")
        label.textAlignment = .left

        return label
    }()

    let uploadImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "upload")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1

        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(cellView)
        cellView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailling: trailingAnchor, size: .init(width: 0, height: 140))

        cellView.addSubview(leftLineView)
        leftLineView.anchor(top: cellView.topAnchor, leading: cellView.leadingAnchor, bottom: cellView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 24, bottom: 12, right: 0), size: .init(width: 5, height: 0))

        cellView.addSubview(uploadImage)
        uploadImage.anchor(top: leftLineView.topAnchor, leading: nil, bottom: nil, trailling: cellView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12), size: .init(width: 30, height: 30))

        cellView.addSubview(dateLabel)
        dateLabel.anchor(top: leftLineView.topAnchor, leading: leftLineView.trailingAnchor, bottom: nil, trailling: uploadImage.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0), size: .init(width: 0, height: 30))

        cellView.addSubview(titleLabel)
        titleLabel.anchor(top: dateLabel.bottomAnchor, leading: leftLineView.trailingAnchor, bottom: cellView.bottomAnchor, trailling: cellView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
