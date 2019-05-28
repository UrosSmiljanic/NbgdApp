//
//  SingleEventScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 04/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class SingleEventScreen: BaseViewController {

    var event: SingleEvent?

    var id = ""
    var pageTitle: String?

    let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

//    let calendarButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
//        button.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
//        return button
//    }()
//
//    @objc func openCalendar() {
//        print("Open Calendar")
//    }

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "323334")
        return view
    }()

    let eventThumbail: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    let eventText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "http://ey.nbgcreator.com/api/news/event?lang=\(defaultLanguage)&id="

        fetchGenericData(urlString: url + id) { (data: SingleEvent?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }

            DispatchQueue.main.async {
                self.pageTitleLabel.text = self.pageTitle
                self.dateLabel.text = data?.entity?.publishDate
                self.titleLabel.text = data?.entity?.title
                if let url = data?.entity?.image {
                    self.eventThumbail.load(url: URL(string: url)!)
                }
                self.eventText.attributedText = formatHtmlString(htmlString: (data?.entity?.text)!)
                self.setupViews()
                self.removeSpinner()
            }
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
    }
    
    func setupViews() {

        

        view.addSubview(pageTitleLabel)
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

//        view.addSubview(calendarButton)
//        calendarButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: pageTitleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))

        view.addSubview(headerView)
        headerView.anchor(top: pageTitleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: screensize.width, height: 140))

        setHeaderView()

        view.addSubview(eventThumbail)
        eventThumbail.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 100))

        view.addSubview(eventText)
        eventText.anchor(top: eventThumbail.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }

    let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.textColor = UIColor(hexString: "FEE433")
        label.textAlignment = .left

        return label
    }()

    let downloadImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "downlod")
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
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }()

    func setHeaderView() {

        headerView.addSubview(leftLineView)
        leftLineView.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 24, bottom: 12, right: 0), size: .init(width: 5, height: 0))

        headerView.addSubview(downloadImage)
        downloadImage.anchor(top: leftLineView.topAnchor, leading: nil, bottom: nil, trailling: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12), size: .init(width: 30, height: 30))

        headerView.addSubview(dateLabel)
        dateLabel.anchor(top: leftLineView.topAnchor, leading: leftLineView.trailingAnchor, bottom: nil, trailling: downloadImage.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0), size: .init(width: 0, height: 30))

        headerView.addSubview(titleLabel)
        titleLabel.anchor(top: dateLabel.bottomAnchor, leading: leftLineView.trailingAnchor, bottom: headerView.bottomAnchor, trailling: headerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 0))

    }
}
