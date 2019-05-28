//
//  SingleNewsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 18/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit
import WebKit

class SingleNewsScreen: BaseViewController {
    
    let cellId = "collectionCell"
    
    var collectionView: UICollectionView!
    
    var singleNews: SingleNews?
    var id: String?
    var singleNewsTitle: String?
    var isVideo = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        
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

        shareData = shareData + newsText.text!//singleNews!.entity.text

        shareData.share()
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()
    
    let newsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        
        return label
    }()
    
    let publishDateHolder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
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
    
    let publishDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    let publishTime: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    let newsThumbail: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    var link: URL!

    let newsText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.isUserInteractionEnabled = true

        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gestureAction)))

        return label
    }()

    @objc func gestureAction(_ recognizer: UITapGestureRecognizer) {

        guard let text = newsText.attributedText?.string else {
            return
        }

        if let range = text.range(of: NSLocalizedString("link", comment: "terms")),
            recognizer.didTapAttributedTextInLabel(label: newsText, inRange: NSRange(range, in: text)) {
            if let url = link {
                UIApplication.shared.open(url, options: [:])
            }
        } else if let range = text.range(of: NSLocalizedString("линку", comment: "privacy")),
            recognizer.didTapAttributedTextInLabel(label: newsText, inRange: NSRange(range, in: text)) {
            if let url = link {
                UIApplication.shared.open(url, options: [:])

            }
        }

    }
    
    let relatedNewsHolder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let relatedNewTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = UIColor(hexString: "DFDFDF")
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://ey.nbgcreator.com/api/news/article?lang=\(defaultLanguage)&id=\(id ?? "")"
        
        titleLabel.text = singleNewsTitle

        fetchGenericData(urlString: url) { (data: SingleNews?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            fetchGenericDataGrid(urlString: url) { (data: SingleNews) in
                self.singleNews = data
                DispatchQueue.main.async {

                    self.titleLabel.text = self.singleNewsTitle
                    self.newsTitle.text = data.entity.title
                    self.publishDate.text = String(data.entity.publishDate.prefix(11))
                    self.publishTime.text = String(data.entity.publishDate.suffix(5))
                    self.newsThumbail.load(url: URL(string: data.entity.image)!)

                    if data.entity.relatedArticles.count == 0 {

                        self.setupViews(reletedArticle: false)

                    } else {

                        self.setupViews(reletedArticle: true)
                    }


                   // self.newsText.attributedText = formatHtmlString(htmlString: data.entity.text)

                    let htmlString = data.entity.text
                    // works even without <html><body> </body></html> tags, BTW
                    let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
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

                    if htmlString.extractURLs().count > 0 {
                        attributedString.setAsLink(textToFind: urlLink, linkURL: htmlString.extractURLs()[0])
                        self.link = htmlString.extractURLs()[0]
                    }

                    self.newsText.attributedText = attributedString


                    self.collectionView.reloadData()
                    self.removeSpinner()
                }
            }
        }

        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RelatedNewsCell.self, forCellWithReuseIdentifier: cellId)
        //        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CartHeaderCollectionReusableView")
        collectionView.backgroundColor = UIColor.white
    }

    
    func setupViews(reletedArticle: Bool) {
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))
        
        view.addSubview(shareButton)
        shareButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))
        
        view.addSubview(scrollView)
        scrollView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)
        
        scrollView.addSubview(headerView)
        headerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, size: .init(width: screensize.width, height: 100))
        
        scrollView.addSubview(newsThumbail)
        newsThumbail.anchor(top: headerView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, size: .init(width: 0, height: screensize.width / 2.5))
        
        scrollView.addSubview(publishDateHolder)
        publishDateHolder.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 75, left: (screensize.width / 2) - 125, bottom: 0, right: 0), size: .init(width: 250, height: 50))
        
        headerView.addSubview(newsTitle)
        newsTitle.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: publishDateHolder.topAnchor, trailling: headerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        
        publishDateHolder.addSubview(calThumbail)
        calThumbail.anchor(top: publishDateHolder.topAnchor, leading: publishDateHolder.leadingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 0), size: .init(width: 22, height: 22))
        
        publishDateHolder.addSubview(publishDate)
        publishDate.anchor(top: publishDateHolder.topAnchor, leading: calThumbail.trailingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))
        
        publishDateHolder.addSubview(timeThumbail)
        timeThumbail.anchor(top: publishDateHolder.topAnchor, leading: publishDate.trailingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 0), size: .init(width: 22, height: 22))
        
        publishDateHolder.addSubview(publishTime)
        publishTime.anchor(top: publishDateHolder.topAnchor, leading: timeThumbail.trailingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))

        if isVideo {
            let webView: WKWebView = {
                let view = WKWebView()
                return view
            }()

            if let videoUrl = singleNews?.entity.text {
                var url = videoUrl.replacingOccurrences(of: "560", with: "\(screensize.width * 2.3)")
                url = url.replacingOccurrences(of: "314", with: "\(screensize.width * 1.28)")
                webView.loadHTMLString(url, baseURL: nil)
            }

            scrollView.addSubview(webView)
            webView.anchor(top: newsThumbail.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)

        } else {
            if reletedArticle {

                let leftArrow: UIImageView = {
                    let view = UIImageView()
                    view.image = #imageLiteral(resourceName: "leftArrow")
                    view.contentMode = .scaleAspectFill
                    return view
                }()

                let rightArrow: UIImageView = {
                    let view = UIImageView()
                    view.image = #imageLiteral(resourceName: "rightArrow")
                    view.contentMode = .scaleAspectFill
                    return view
                }()

                if defaultLanguage == "sr" {
                    relatedNewTitle.text = "  Повезане вести"
                } else {
                    relatedNewTitle.text = "  Related article"
                }

                scrollView.addSubview(newsText)
                newsText.anchor(top: newsThumbail.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailling: scrollView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

                scrollView.addSubview(relatedNewsHolder)
                relatedNewsHolder.anchor(top: newsText.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailling: scrollView.trailingAnchor, size: .init(width: screensize.width, height: 265))

                relatedNewsHolder.addSubview(relatedNewTitle)
                relatedNewTitle.anchor(top: relatedNewsHolder.topAnchor, leading: relatedNewsHolder.leadingAnchor, bottom: nil, trailling: relatedNewsHolder.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 40))

                relatedNewTitle.addSubview(rightArrow)
                rightArrow.anchor(top: relatedNewTitle.topAnchor, leading: nil, bottom: relatedNewTitle.bottomAnchor, trailling: relatedNewTitle.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 4, right: 4))

                relatedNewTitle.addSubview(leftArrow)
                leftArrow.anchor(top: relatedNewTitle.topAnchor, leading: nil, bottom: relatedNewTitle.bottomAnchor, trailling: rightArrow.leadingAnchor, padding: .init(top: 4, left: 0, bottom: 4, right: 4))

                relatedNewsHolder.addSubview(collectionView)
                collectionView.anchor(top: relatedNewTitle.bottomAnchor, leading: relatedNewsHolder.leadingAnchor, bottom: relatedNewsHolder.bottomAnchor, trailling: relatedNewsHolder.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))

            } else {

                scrollView.addSubview(newsText)
                newsText.anchor(top: newsThumbail.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailling: scrollView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

            }
        }


        
        scrollView.resizeScrollViewContentSize()
    }
    
}

extension SingleNewsScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderId", for: indexPath) //as! HeaderClassname
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                headerView.backgroundColor = .orange
            } else {
            }
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 105)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return singleNews?.entity.relatedArticles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RelatedNewsCell
        
        cell.thumbail.load(url: URL(string: (singleNews?.entity.relatedArticles[indexPath.item].thumbnail)!)!)
        cell.title.text = singleNews?.entity.relatedArticles[indexPath.item].title
        
        cell.publishDate.text = String((singleNews?.entity.relatedArticles[indexPath.item].publishDate.prefix(11))!)
        cell.publishTime.text = String((singleNews?.entity.relatedArticles[indexPath.item].publishDate.suffix(5))!)
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screen = SingleNewsScreen()
        screen.id = singleNews?.entity.relatedArticles[indexPath.item].id
        screen.singleNewsTitle = singleNewsTitle

//        if newsType == "video" {
//            screen.isVideo = true
//        }

        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }
    
    
}
