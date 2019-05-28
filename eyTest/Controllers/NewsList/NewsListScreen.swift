//
//  NewsListScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 18/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class NewsListScreen: BaseViewController {

    let cellId = "collectionCell"

    var newsType = ""
    
    var collectionView: UICollectionView!
    
    var newsList: NewsList?
    var id: String?
    var newsListTitle: String?
    
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

        var url = "http://ey.nbgcreator.com/api/news/articles/?lang=\(defaultLanguage)&category=\(id ?? "")"

        switch newsType {
        case "industry":
            url = "http://ey.nbgcreator.com/api/news/industry_overview?lang=\(defaultLanguage)&ids[]=\(id ?? "")"
        case "video":
            url = "http://ey.nbgcreator.com/api/news/videos?lang=\(defaultLanguage)"
        default:
            break
        }

        fetchGenericData(urlString: url) { (data: NewsList?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.newsList = data
            DispatchQueue.main.async {
                self.setupViews()
                self.titleLabel.text = self.newsListTitle
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(sortByNew), name: NSNotification.Name(rawValue: "sortByNew"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(sortByMostRead), name: NSNotification.Name(rawValue: "sortByMostRead"), object: nil)

        setupCollectionView()
    }

    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NewsListCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.white
    }



    
    func setupViews() {
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 70))
        
        view.addSubview(sortButton)
        sortButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))
        
        view.addSubview(collectionView)
        
        collectionView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }

    @objc func sortByNew() {

        var url = "http://ey.nbgcreator.com/api/news/articles/?lang=\(defaultLanguage)&category=\(id ?? "")&sort=new"

        switch newsType {
        case "industry":
            url = "http://ey.nbgcreator.com/api/news/industry_overview?lang=\(defaultLanguage)&ids[]=\(id ?? "")&sort=new"
        case "video":
            url = "http://ey.nbgcreator.com/api/news/videos?lang=\(defaultLanguage)&sort=new"
        default:
            break
        }

        fetchGenericData(urlString: url) { (data: NewsList?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.newsList = data
            DispatchQueue.main.async {
                self.setupViews()
                self.titleLabel.text = self.newsListTitle
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }
    }

    @objc func sortByMostRead() {

        var url = "http://ey.nbgcreator.com/api/news/articles/?lang=\(defaultLanguage)&category=\(id ?? "")&sort=read"

        switch newsType {
        case "industry":
            url = "http://ey.nbgcreator.com/api/news/industry_overview?lang=\(defaultLanguage)&ids[]=\(id ?? "")&sort=read"
        case "video":
            url = "http://ey.nbgcreator.com/api/news/videos?lang=\(defaultLanguage)&sort=read"
        default:
            break
        }

        fetchGenericData(urlString: url) { (data: NewsList?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.newsList = data
            DispatchQueue.main.async {
                self.setupViews()
                self.titleLabel.text = self.newsListTitle
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }
    }

}

extension NewsListScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 105)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList?.entity.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsListCell

        if let url = newsList?.entity.list[indexPath.item].thumbnail {
            cell.thumbail.load(url: URL(string: url)!)
        }

       //cell.thumbail.load(url: URL(string: (newsList?.entity.list[indexPath.item].thumbnail)!)!)

        cell.title.text = newsList?.entity.list[indexPath.item].title
        
        cell.publishDate.text = String((newsList?.entity.list[indexPath.item].publishDate.prefix(11))!)
        cell.publishTime.text = String((newsList?.entity.list[indexPath.item].publishDate.suffix(5))!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let screen = SingleNewsScreen()
        screen.id = newsList?.entity.list[indexPath.item].id
        screen.singleNewsTitle = newsListTitle

        if newsType == "video" {
            screen.isVideo = true
        }
        
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }
    
}
