//
//  SingleTaxNewsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 01/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class SingleTaxNewsScreen: BaseViewController {

    var taxTitle = ""
    var id = "0"
    var link: URL!

    var taxNews: SingleTaxNews?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.addTarget(self, action: #selector(handleShareAction), for: .touchUpInside)
        return button
    }()

    @objc func handleShareAction() {
        var shareData = titleLabel.text! + "\n"

        shareData = shareData + newsText.text!//taxNews!.entity!.text!

        shareData.share()
    }

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    let titleViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    let newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let thumbailImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "settings-img")
        return view
    }()

    let calTimeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.layer.borderColor = UIColor(hexString: "DFDFDF").cgColor
//        view.layer.borderWidth = 2
        return view
    }()

    let calThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "calendar")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    let timeThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "clock")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    let publishDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        label.text = "09.04.2018"

        return label
    }()

    let publishTime: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        label.text = "15:30h"

        return label
    }()

    let newsText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = true

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = taxTitle

        let url = "http://ey.nbgcreator.com/api/news/article?lang=\(defaultLanguage)&id=" + id

        fetchGenericData(urlString: url) { (data: SingleTaxNews?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }

            self.taxNews = data
            DispatchQueue.main.async {

                self.newsTitle.text = data!.entity?.title
                self.publishDate.text = String((data!.entity?.publishDate!.prefix(11))!)
                self.publishTime.text = String((data!.entity?.publishDate!.suffix(5))!)
//                self.newsThumbail.load(url: URL(string: data!.entity.image)!)
//                self.newsText.attributedText = formatHtmlString(htmlString: (data!.entity?.text)!)

                let htmlString = data!.entity!.text
                // works even without <html><body> </body></html> tags, BTW
                let data = htmlString!.data(using: String.Encoding.unicode)! // mind "!"
                let attrStr = try? NSAttributedString( // do catch
                    data: data,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                // suppose we have an UILabel, but any element with NSAttributedString will do

                let attriString = NSAttributedString(string: (attrStr?.string)!, attributes:
                    [NSAttributedString.Key.foregroundColor: UIColor.black,
                     NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 17)!])

                let attributedString = NSMutableAttributedString(attributedString: attriString)

                var urlLink = ""
                if self.defaultLanguage == "sr" {
                    urlLink = "линку"
                } else {
                    urlLink = "link"
                }

                if htmlString!.extractURLs().count > 0 {
                    attributedString.setAsLink(textToFind: urlLink, linkURL: htmlString!.extractURLs()[0])
                    self.link = htmlString!.extractURLs()[0]
                }

                self.newsText.attributedText = attributedString

                self.setupView()
                self.removeSpinner()
            }
        }


    }
    

    fileprivate func setCalAndTime() {
        calTimeView.addSubview(calThumbail)
        calThumbail.anchor(top: calTimeView.topAnchor, leading: calTimeView.leadingAnchor, bottom: calTimeView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 30, height: 30))

        calTimeView.addSubview(publishDate)
        publishDate.anchor(top: calTimeView.topAnchor, leading: calThumbail.trailingAnchor, bottom: calTimeView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 8, bottom: 12, right: 0))

//        calTimeView.addSubview(timeThumbail)
//        timeThumbail.anchor(top: calTimeView.topAnchor, leading: publishDate.trailingAnchor, bottom: calTimeView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 30, height: 30))
//
//        calTimeView.addSubview(publishTime)
//        publishTime.anchor(top: calTimeView.topAnchor, leading: timeThumbail.trailingAnchor, bottom: calTimeView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 8, bottom: 12, right: 0))
    }

    fileprivate func setupView() {

        

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(shareButton)
        shareButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 12))

        view.addSubview(scrollView)
        scrollView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)

        scrollView.addSubview(titleViewContainer)
        titleViewContainer.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, size: .init(width: screensize.width, height: 100))

        titleViewContainer.addSubview(newsTitle)
        newsTitle.anchor(top: titleViewContainer.topAnchor, leading: titleViewContainer.leadingAnchor, bottom: titleViewContainer.bottomAnchor, trailling: titleViewContainer.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

        scrollView.addSubview(thumbailImage)
        thumbailImage.anchor(top: titleViewContainer.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: titleViewContainer.trailingAnchor, size: .init(width: 0, height: 60))

        scrollView.addSubview(calTimeView)
        calTimeView.anchor(top: thumbailImage.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: titleViewContainer.trailingAnchor, size: .init(width: 0, height: 50))

        setCalAndTime()

        scrollView.addSubview(newsText)
        newsText.anchor(top: calTimeView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailling: titleViewContainer.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

        scrollView.resizeScrollViewContentSize()

    }


}
