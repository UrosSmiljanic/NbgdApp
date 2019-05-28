//
//  SingleTaxCalendarScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 21/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class SingleTaxCalendarScreen: BaseViewController {

    var id = ""

    let scrollView: UIScrollView = {
        let view = UIScrollView()

        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "DFDFDF")
        return view
    }()

    let thumbailImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "taxHeader")
        view.clipsToBounds = true
        return view
    }()

    let informationText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
//        label.isUserInteractionEnabled = true

        // label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gestureAction)))

        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)

        return label
    }()

    let taxCalTitlLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)

        return label
    }()

    let viewThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "view")
        view.contentMode = .scaleAspectFill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if defaultLanguage == "sr" {
            titleLabel.text = "Порески календар"
        } else {
            titleLabel.text = "Tax Calendar"
        }

        let url = "http://ey.nbgcreator.com/api/calendar/single?lang=\(defaultLanguage)&id=\(id)"

        fetchGenericData(urlString: url) { (data: SingleCalendar?, error) in
            if error != nil {
                self.showErrorMessage()
                return
            }

            DispatchQueue.main.async {
                self.informationText.attributedText = formatHtmlString(htmlString: (data?.entity.description)!)
                self.dateLabel.text = data?.entity.date
                self.setupView()
                self.removeSpinner()
            }
        }


    }
    
    fileprivate func setupView() {

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        //    view.addSubview(shareButton)
        //    shareButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))

        view.addSubview(scrollView)
        scrollView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)

        scrollView.addSubview(headerView)
        headerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, size: .init(width: screensize.width, height: 100))

        headerView.addSubview(dateLabel)
        dateLabel.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        headerView.addSubview(taxCalTitlLabel)
        taxCalTitlLabel.anchor(top: dateLabel.bottomAnchor, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailling: headerView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))

        headerView.addSubview(viewThumbail)
        viewThumbail.anchor(top: headerView.topAnchor, leading: nil, bottom: nil, trailling: headerView.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 4), size: .init(width: 30, height: 30))

        scrollView.addSubview(thumbailImage)
        thumbailImage.anchor(top: headerView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, size: .init(width: 0, height: 60))

        scrollView.addSubview(informationText)
        informationText.anchor(top: thumbailImage.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

        scrollView.resizeScrollViewContentSize()
    }


}
