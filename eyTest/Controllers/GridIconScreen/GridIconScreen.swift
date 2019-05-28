//
//  MenuScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit
import SVGKit

class GridIconScreen: BaseViewController {

    let cellId = "myCell"
    var collectionView: UICollectionView!
    
    var gridIconData: GridIconModel?
    var submenu = false

    var id: String?
    
    let thumbailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
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


        var url = "http://ey.nbgcreator.com/api/menu?lang=\(defaultLanguage)&id=\(id ?? "")"

        if submenu {
            submenu = false
            url = "http://ey.nbgcreator.com/api/menu/submenu?lang=\(defaultLanguage)"
        }

//        fetchGenericData(urlString: url) { (data: GridIconModel?, err) in
////            if err != nil {
////                self.errorMessage.isHidden = false
//                self.removeSpinner()
////                return
////            }
//            DispatchQueue.main.async {
//                self.setupViews()
//                if let imageString = data!.entity.header {
//                    self.thumbailImageView.load(url: URL(string: imageString)!)
//                } else {
//                    self.thumbailImageView.image = #imageLiteral(resourceName: "aboutUsHeader")
//                }
//                if let title = data!.entity.title {
//                    self.titleLabel.text = title
//                } else {
//                    self.titleLabel.text = "O kompaniji"
//                }
//
//                self.collectionView.reloadData()
//                self.removeSpinner()
//
//            }
//        }


        fetchGenericDataGrid(urlString: url) { (data: GridIconModel) in
            self.gridIconData = data
            DispatchQueue.main.async {

                self.setupViews()
                if let imageString = data.entity.header {
                    self.thumbailImageView.load(url: URL(string: imageString)!)
                } else {
                    self.thumbailImageView.image = #imageLiteral(resourceName: "aboutUsHeader")
                }
                if let title = data.entity.title {
                    self.titleLabel.text = title
                } else {

                    if self.defaultLanguage == "sr" {
                        self.titleLabel.text = "О компанији"
                    } else {
                        self.titleLabel.text = "About the Company"
                    }

                }

                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }

        setupCollectionView()
        
    }
    
    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GridIconModelCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
    }


    
    func setupViews() {
        
        view.addSubview(thumbailImageView)
        thumbailImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: view.frame.height / 4))
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: thumbailImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        
        view.addSubview(collectionView)
        
        collectionView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }

    func  handleAppNavigation(type: String, id: String, title: String) {


        switch type {
        case "news_list":
            let screen = NewsListScreen()
            screen.id = id
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
            
        case "video_list":
            let screen = NewsListScreen()
            screen.newsType = "video"
            screen.newsListTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        case "calculator_earnings":
            let screen = CalculatorEarningsScreen()
            screen.choosenByUser.titleType = "earnings"
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "calculator_service_contract":
            let screen = CalculatorEarningsScreen()
            screen.choosenByUser.titleType = "contract"
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)

        case "calculator_annual_tax":
            let screen = YearlyCalculatorScreen()
            screen.choosenByUser.calculationType = "godisnjiN"
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        case "event_list":
            let screen = EYEventScreen()
            screen.pageTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        case "expandable_list":
            let screen = ExpandableListScreen()
            screen.pageTitle = title
            screen.isFaqList = false
            screen.id = id
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        case "calendar":
//            let screen = TaxCalendarScreen()
//            screen.pageTitle = title
//            screen.currentYear = defaults.integer(forKey: "currentYear")
//            screen.currentMonth = defaults.integer(forKey: "currentMonth")
//            screen.currentDay = defaults.integer(forKey: "currentDay")
//            let vc = UINavigationController(rootViewController: screen)
//            present(vc, animated: true, completion: nil)
            let screen = CalendarScreen()
            screen.pageTitleLabel.text = title
            
            screen.isFrom = "taxCalendar"
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        case "poll_list":
            let screen = PollListScreen()
            screen.pageTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        case "page_view":
            let screen = PageViewScreen()
            screen.id = id
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        case "grid_bg_contact":
            let screen = GridContactScreen()
            screen.id = id
            screen.pageTitle = title
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        default:
            print("Under Construction: \(type)")
        }
    }

}

extension GridIconScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        if (gridIconData?.entity.list.count ?? 0) % 2 == 0 {
            
            let width = (collectionView.frame.width - 20) / 2

            return CGSize(width: width, height: width)
            
        }else {
            
            if (gridIconData?.entity.list.count ?? 0) - 1 == indexPath.row {
                let width = collectionView.frame.width //- 10
                let height : CGFloat = (collectionView.frame.width - 10) / 2

                return CGSize(width: width, height: height)
            }else{
                let width = (collectionView.frame.width-20)/2

                return CGSize(width: width, height: width)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridIconData?.entity.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GridIconModelCell
        
        let svgURL = URL(string: gridIconData?.entity.list[indexPath.item].icon ?? "http://ey.nbgcreator.com/public/uploads/menu_items/icons/5be55e2c46397.svg")
        let data = try? Data(contentsOf: svgURL!)
        let receivedIcon: SVGKImage = SVGKImage(data: data)
        
        cell.iconImageView.image = receivedIcon.uiImage
        
        cell.titleLabel.text = gridIconData?.entity.list[indexPath.item].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let objectid = gridIconData?.entity.list[indexPath.item].objectID, let type = gridIconData?.entity.list[indexPath.item].type, let title = gridIconData?.entity.list[indexPath.item].title {
            handleAppNavigation(type: type, id: objectid, title: title)
        } else if let id = gridIconData?.entity.list[indexPath.item].id, let type = gridIconData?.entity.list[indexPath.item].type, let title = gridIconData?.entity.list[indexPath.item].title {
            handleAppNavigation(type: type, id: id, title: title)
        }
    }
    
}
