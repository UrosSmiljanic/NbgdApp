//
//  TableViewCell.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 27/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {

    let resultType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let resultValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(resultType)
        resultType.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailling: nil, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: (contentView.layer.bounds.width / 2), height: 0))

        addSubview(resultValue)
        resultValue.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailling: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 12), size: .init(width: (contentView.layer.bounds.width / 3), height: 0))
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
