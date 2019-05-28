//
//  TaxNewsletterScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 20/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit
//import UPCarouselFlowLayout

class TaxNewsletterScreen: BaseViewController {
    
    var newsletter: TaxNewsletterModel?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let sortButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "sort"), for: .normal)
        button.addTarget(self, action: #selector(handleSortAction), for: .touchUpInside)
        return button
    }()

    @objc func handleSortAction() {
        showSortNewsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if defaultLanguage == "sr" {
            titleLabel.text = "Порески гласник"
        } else {
            titleLabel.text = "Tax newsletter"
        }

        let url = "http://ey.nbgcreator.com/api/news/tax_newsletter?lang=\(defaultLanguage)"

        fetchGenericData(urlString: url) { (data: TaxNewsletterModel?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }

            self.newsletter = data
            DispatchQueue.main.async {
                self.setupView()
                self.initiCarousel()
                self.removeSpinner()
            }
        }

        NotificationCenter.default.addObserver(self, selector: #selector(sortByNew), name: NSNotification.Name(rawValue: "sortByNew"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(sortByMostRead), name: NSNotification.Name(rawValue: "sortByMostRead"), object: nil)

    }

    @objc func sortByNew() {

        let url = "http://ey.nbgcreator.com/api/news/tax_newsletter?lang=\(defaultLanguage)&sort=new"


        fetchGenericData(urlString: url) { (data: TaxNewsletterModel?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }

            self.newsletter = data
            DispatchQueue.main.async {
                self.setupView()
                self.initiCarousel()
                self.removeSpinner()
            }
        }
    }

    @objc func sortByMostRead() {

        let url = "http://ey.nbgcreator.com/api/news/tax_newsletter?lang=\(defaultLanguage)&sort=read"

        fetchGenericData(urlString: url) { (data: TaxNewsletterModel?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }

            self.newsletter = data
            DispatchQueue.main.async {
                self.setupView()
                self.initiCarousel()
                self.removeSpinner()
            }
        }
    }

    fileprivate func setupView() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(sortButton)
        sortButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))
    }

    private func initiCarousel() {
        let carousel = iCarousel()//(frame: CGRect(x: 0, y: 0/*view.frame.height - HEIGHT_CAROUSEL*/, width: view.frame.width, height: view.frame.height/*HEIGHT_CAROUSEL*/))
        carousel.type = .coverFlow
        carousel.delegate = self
        carousel.dataSource = self
        view.addSubview(carousel)
        carousel.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)
    }


}

extension TaxNewsletterScreen: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return newsletter?.entity.count ?? 0
    }


    fileprivate func setCarouselView(_ itemView: UIView, _ publishDate: UILabel, _ publishTime: UILabel, _ titleLabel: UILabel) {
        let triangleImage: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleToFill
            view.image = #imageLiteral(resourceName: "trougao")
            return view
        }()

        let footerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.borderColor = UIColor(hexString: "DFDFDF").cgColor
            view.layer.borderWidth = 2
            return view
        }()

        let calThumbail: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "calendar")
            view.contentMode = .scaleAspectFill
            return view
        }()

        let timeThumbail: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "clock")
            view.contentMode = .scaleAspectFill
            return view
        }()



        let thumbailImage: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.image = #imageLiteral(resourceName: "settings-img")
            return view
        }()

        itemView.addSubview(triangleImage)
        triangleImage.anchor(top: itemView.topAnchor, leading: itemView.leadingAnchor, bottom: nil, trailling: itemView.trailingAnchor, size: .init(width: 0, height: 50))

        itemView.addSubview(footerView)
        footerView.anchor(top: nil, leading: itemView.leadingAnchor, bottom: itemView.bottomAnchor, trailling: itemView.trailingAnchor, size: .init(width: 0, height: 50))

        footerView.addSubview(calThumbail)
        calThumbail.anchor(top: footerView.topAnchor, leading: footerView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 12, left: 5, bottom: 0, right: 0), size: .init(width: 24, height: 24))

        footerView.addSubview(publishDate)
        publishDate.anchor(top: footerView.topAnchor, leading: calThumbail.trailingAnchor, bottom: footerView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))

//        footerView.addSubview(timeThumbail)
//        timeThumbail.anchor(top: footerView.topAnchor, leading: publishDate.trailingAnchor, bottom: nil, trailling: nil, padding: .init(top: 12, left: 5, bottom: 0, right: 0), size: .init(width: 24, height: 24))
//
//        footerView.addSubview(publishTime)
//        publishTime.anchor(top: footerView.topAnchor, leading: timeThumbail.trailingAnchor, bottom: footerView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))

        itemView.addSubview(thumbailImage)
        thumbailImage.anchor(top: nil, leading: itemView.leadingAnchor, bottom: footerView.topAnchor, trailling: itemView.trailingAnchor, size: .init(width: 0, height: 50))

        itemView.addSubview(titleLabel)
        titleLabel.anchor(top: triangleImage.bottomAnchor, leading: itemView.leadingAnchor, bottom: thumbailImage.topAnchor, trailling: itemView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIView
        itemView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
        itemView.backgroundColor = UIColor(hexString: "FEE433")

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

        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Amendments of Laws on employment of foreigners and secondment of employees abroad"
            label.font = UIFont(name: "EYInterstate-Bold", size: 20)
            label.numberOfLines = 0
            label.textAlignment = .left
            label.lineBreakMode = .byWordWrapping
            return label
        }()

        setCarouselView(itemView, publishDate, publishTime, titleLabel)

        titleLabel.text = newsletter?.entity[index].title
        publishDate.text = String((newsletter?.entity[index].publishDate.prefix(11))!)
        publishTime.text = String((newsletter?.entity[index].publishDate.suffix(5))!) + "h"

        return itemView
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 2.1
        }
        return value
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let screen = SingleTaxNewsScreen()
        if let title = titleLabel.text, let id = newsletter?.entity[index].id {
            screen.taxTitle = title
            screen.id = id
        }

        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }
}
