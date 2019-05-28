//
//  IndustryOverviewScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 28/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit
import SVGKit

class IndustryOverviewScreen: BaseViewController {

    let cellId = "collectionCell"
    var collectionView: UICollectionView!

    var selectedIndustry: IndustryOverview?

    var industryOverviewTitle: String?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        var string = ""

        for i in 0 ..< choosenIndustry.count {
            string = string + "&ids[]=\(choosenIndustry[i])"
        }

         let url = "https://ey.nbgcreator.com/api/news/get_by_categories?lang=\(defaultLanguage)\(string)"

        fetchGenericData(urlString: url) { (data: IndustryOverview?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.selectedIndustry = data

            DispatchQueue.main.async {
                self.setupViews()
                self.titleLabel.text = self.industryOverviewTitle
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }

//        fetchGenericData(urlString: url) { (data: IndustryOverview) in
//            self.selectedIndustry = data
//
//            DispatchQueue.main.async {
//                self.setupViews()
//                self.titleLabel.text = self.industryOverviewTitle
//                self.collectionView.reloadData()
//                self.removeSpinner()
//            }
//        }

        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GridIconModelCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.backgroundColor = UIColor.white
    }

    func setupViews() {

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(collectionView)

        collectionView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }

}

extension IndustryOverviewScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! FooterView
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        // return CGSize(collectionView.frame.width, 20)
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / 2)//collectionView.frame.height - (((collectionView.frame.width - 10) / 2) * 2) - 30)
        //        return .init(width: collectionView.frame.width, height: 72)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if (selectedIndustry?.entity.list.count ?? 0) % 2 == 0 {

            let width = (collectionView.frame.width - 20) / 2

            return CGSize(width: width, height: width)

        }else {

            if (selectedIndustry?.entity.list.count ?? 0) - 1 == indexPath.row {
                let width = collectionView.frame.width //- 10
                let height : CGFloat = (collectionView.frame.width - 10) / 2

                return CGSize(width: width, height: height)
            }else{
                let width = (collectionView.frame.width-20)/2

                return CGSize(width: width, height: width)
            }
        }

    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedIndustry?.entity.list.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GridIconModelCell

        let svgURL = URL(string: selectedIndustry?.entity.list[indexPath.item].icon ?? "http://ey.nbgcreator.com/public/uploads/menu_items/icons/5be55e2c46397.svg")
        let data = try? Data(contentsOf: svgURL!)
        let receivedIcon: SVGKImage = SVGKImage(data: data)

        cell.iconImageView.image = receivedIcon.uiImage

        cell.titleLabel.text = selectedIndustry?.entity.list[indexPath.item].name

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let id = selectedIndustry?.entity.list[indexPath.item].id, let title = selectedIndustry?.entity.list[indexPath.item].name {
            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        }
    }

}
