//
//  HomeScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class FooterView: UICollectionReusableView {
    
    let thumbailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "ey-footer-600x337")
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        addSubview(seperatorView)
//        seperatorView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailling: self.trailingAnchor, size: .init(width: 0, height: 20))
        
        addSubview(thumbailImageView)
        thumbailImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailling: self.trailingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has notvaren implemented")
    }
    
}


class HomeScreen: BaseViewController {
    
    let cellId = "myCell"
    
    var collectionView: UICollectionView!
    
    var homeScreenData: HomeScreenModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://ey.nbgcreator.com/api/menu?lang=\(defaultLanguage)"
        
        fetchGenericData(urlString: url) { (data: HomeScreenModel?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.homeScreenData = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }
        
        //        fetchGenericData(urlString: url) { (data: HomeScreenModel) in
        //            self.homeScreenData = data
        //            DispatchQueue.main.async {
        //                self.collectionView.reloadData()
        //                self.removeSpinner()
        //            }
        //        }
        
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeScreenCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        
        
        view.addSubview(collectionView)
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    
    
    func  handleAppNavigation(type: String, id: String, title: String) {
        switch type {
        case "industry_overview_grid":
            
            let screen = IndustryOverviewScreen()
            screen.industryOverviewTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
            
        case "grid_icon":
            
            let screen = GridIconScreen()
            screen.id = id
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
            
        case "swiped_list":
            let vc = UINavigationController(rootViewController: TaxNewsletterScreen())
            present(vc, animated: true, completion: nil)
        default:
            print("Under Construction")
        }
    }
    
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! FooterView
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
       
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / 2)
        // return CGSize(collectionView.frame.width, 20)
       // return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - (((collectionView.frame.width - 10) / 2) * 3) - 40)
        //        return .init(width: collectionView.frame.width, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 10) / 2
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeScreenData?.entity.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeScreenCell
        
        cell.thumbailImageView.load(url: URL(string: (homeScreenData?.entity.list[indexPath.item].image)!)!)
        
        cell.titleLabel.text = homeScreenData?.entity.list[indexPath.item].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let id = homeScreenData?.entity.list[indexPath.item].id, let type = homeScreenData?.entity.list[indexPath.item].type, let title = homeScreenData?.entity.list[indexPath.item].title {
            handleAppNavigation(type: type, id: id, title: title)
        }
    }
    
}
