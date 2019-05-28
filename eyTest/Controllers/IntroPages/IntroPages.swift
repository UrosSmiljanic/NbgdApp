//
//  IntroPages.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 12/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class IntroPages: UIViewController {
    
    let numOfPages = 4

    let cellId = "myCell"
    var izaberiSveIndustrije = false
    
    var collectionView: UICollectionView!
    
    let introThumbails = ["intro1", "intro2", "intro3"]
    let introEnglishTitles = ["What application offers", "Terms & Conditions", "Push notifications"]
    let introSerbianTitles = ["Шта апликација нуди", "Услови коришћења", "Push нотификације"]
    let introNavigationThumbail = ["settings", "file", "bell", "bullhorn"]
    var errorTitle = ""
    var errorMessage = ""
    
    var introData: IntroPagesModel?
    var introDataSr: IntroPagesSr?
    var industries: Industries?
    var defaultLanguage = "en"
    let defaults = UserDefaults.standard
    var url = ""

    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
        
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = numOfPages
        return pc
    }()
    
    @objc func handleNextPage() {
        
        let nextIndex = min(pageControl.currentPage + 1, numOfPages)
        if nextIndex < numOfPages {
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {

            let cell: IntroPagesCell = collectionView.cellForItem(at: IndexPath(row: 3, section: 0))! as! IntroPagesCell

            if cell.selectedIndustries.count != 0 {
                defaults.set(cell.selectedIndustries, forKey: "ChossenIndustries")
                defaults.set(true, forKey: "introCompleted")
                defaults.synchronize()

                let screen = HomeScreen()
                let vc = UINavigationController(rootViewController: screen)

                present(vc, animated: true, completion: nil)
            } else {

                let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)

            }

        }
        
        if nextIndex == numOfPages - 1 {
            if defaultLanguage == "sr" {
                nextButton.setTitle("Покрени апликацију", for: .normal)
            } else {
                nextButton.setTitle("Run the application", for: .normal)
            }
        } else {
            if defaultLanguage == "sr" {
                nextButton.setTitle("Даље", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        defaultLanguage = defaults.string(forKey: "DefaultLanguage") ?? "en"

        if defaultLanguage == "sr" {

            errorMessage = "Молимо изаберите минимум једну индустрију како бисте покренули апликацију"
            errorTitle = "Дошло је до грешке"

            nextButton.setTitle("Даље", for: .normal)

            url = "http://ey.nbgcreator.com/api/config/?keys[]=mob_intro_app_sr&keys[]=mob_intro_push_sr&keys[]=mob_intro_terms_sr"
            fetchGenericData(urlString: url) { (introData: IntroPagesSr?, err) in
                if err != nil {
                    let screen = BaseViewController()

                    let vc = UINavigationController(rootViewController: screen)
                    self.present(vc, animated: true, completion: {
                        screen.showErrorMessage()
                    })
                    return
                }
                self.introDataSr = introData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.removeSpinner()
                }
            }
        } else {

            errorMessage = "Please select at least one industry to run the application"
            errorTitle = "An error has occurred"

            nextButton.setTitle("Next", for: .normal)

            url = "http://ey.nbgcreator.com/api/config/?keys[]=mob_intro_app_en&keys[]=mob_intro_push_en&keys[]=mob_intro_terms_en"
            fetchGenericData(urlString: url) { (introData: IntroPagesModel?, err) in
                if err != nil {
                    let vc = BaseViewController()
                    vc.showErrorMessage()
                    return
                }
                self.introData = introData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.removeSpinner()
                }
            }
        }
        
        self.showSpinner(onView: self.view)



        let industriesUrl = "http://ey.nbgcreator.com/api/news/categories?lang=\(defaultLanguage)&parent=4"

        fetchGenericData(urlString: industriesUrl) { (data: Industries?, err) in
            if err != nil {
                let vc = BaseViewController()
                vc.showErrorMessage()
                return
            }
            self.industries = data
            //            DispatchQueue.main.async {
            //                self.collectionView.reloadData()
            //                self.removeSpinner()
            //            }
        }

        navigationController?.navigationBar.barStyle = .black

        setupCollectionView()
    }
    

    
    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IntroPagesCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(collectionView)

        collectionView.isPagingEnabled = true

        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 12, right: 10))

        self.view.addSubview(nextButton)
        nextButton.anchor(top: collectionView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: view.frame.width - 24, height: 50))
    }


}

extension IntroPages: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfPages
    }
    
    fileprivate func selectAllIndustries(_ cell: IntroPagesCell) {
        cell.selectAllIndustries()
        cell.itemListCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IntroPagesCell

        //        if indexPath.item < introThumbails.count {
        //            cell.thumbailView.image = UIImage(named: introThumbails[indexPath.item])
        //
        //            if defaultLanguage == "sr" {
        //                cell.titleLabel.text = introSerbianTitles[indexPath.item]
        //            } else {
        //                cell.titleLabel.text = introEnglishTitles[indexPath.item]
        //            }
        //
        //        }

        cell.introNavigation.image = UIImage(named: introNavigationThumbail[indexPath.item])

        switch indexPath.item {
        case 0:
            print("0")
            if defaultLanguage == "sr" {
                cell.introTextView.attributedText = formatHtmlString(htmlString: introDataSr?.entity?.mobIntroAppSr ?? "<html><body> </body></html>")
            } else {
                cell.introTextView.attributedText = formatHtmlString(htmlString: introData?.entity.mobIntroTermsEn ?? "<html><body> </body></html>")
            }

            cell.thumbailView.image = UIImage(named: introThumbails[indexPath.item])

            if defaultLanguage == "sr" {
                cell.titleLabel.text = introSerbianTitles[indexPath.item]
            } else {
                cell.titleLabel.text = introEnglishTitles[indexPath.item]
            }

            if defaultLanguage == "sr" {
                nextButton.setTitle("Даље", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
            return cell
        case 1:
            print("1")
            if defaultLanguage == "sr" {
                cell.introTextView.attributedText = formatHtmlString(htmlString: introDataSr?.entity?.mobIntroTermsSr ?? "<html><body> </body></html>")
            } else {
                cell.introTextView.attributedText = formatHtmlString(htmlString: introData?.entity.mobIntroTermsEn ?? "<html><body> </body></html>")
            }

            cell.thumbailView.image = UIImage(named: introThumbails[indexPath.item])

            if defaultLanguage == "sr" {
                cell.titleLabel.text = introSerbianTitles[indexPath.item]
            } else {
                cell.titleLabel.text = introEnglishTitles[indexPath.item]
            }

            if defaultLanguage == "sr" {
                nextButton.setTitle("Даље", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
            return cell

        case 2:
            print("2")
            if defaultLanguage == "sr" {
                cell.introTextView.attributedText = formatHtmlString(htmlString: introDataSr?.entity?.mobIntroPushSr ?? "<html><body> </body></html>")
            } else {
                cell.introTextView.attributedText = formatHtmlString(htmlString: introData?.entity.mobIntroPushEn ?? "<html><body> </body></html>")
            }

            cell.thumbailView.image = UIImage(named: introThumbails[indexPath.item])

            if defaultLanguage == "sr" {
                cell.titleLabel.text = introSerbianTitles[indexPath.item]
            } else {
                cell.titleLabel.text = introEnglishTitles[indexPath.item]
            }

            if defaultLanguage == "sr" {
                nextButton.setTitle("Даље", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
            return cell

        default:
            print("Settings")
            //            if defaultLanguage == "sr" {
            //                nextButton.setTitle("Покрени апликацију", for: .normal)
            //            } else {
            //                nextButton.setTitle("Run the application", for: .normal)
            //            }

            if let industries = industries {
                cell.setIndustries(industries: industries)
            }

            if defaultLanguage == "sr" {
                cell.infoLabel.text = "Одабиром индустрије филтрирате вести и чланке које ћете примати везано за изабрану индустрију."
                cell.titleLabel.text = "Изабери индустрије"
                cell.chooseAllButton.setTitle("Изабери све индустрије", for: .normal)
            } else {
                cell.infoLabel.text = "By selecting the industry, you filter the news and articles that you will receive about the selected industry."
                cell.titleLabel.text = "Choose industry"
                cell.chooseAllButton.setTitle("Choose all industries", for: .normal)
            }

            cell.setupSettingsView()
            cell.chooseAllButton.addTarget(self, action: #selector(handleChooseAllIndustries), for: .touchUpInside)

            //                cell.chooseAllButton.addTarget(self, action: #selector(selectAllIndustries(_:)), for: .touchUpInside)

            //  selectAllIndustries(cell)
            return cell
        }




    }

    @objc func handleChooseAllIndustries() {
        let cell: IntroPagesCell = collectionView.cellForItem(at: IndexPath(row: 3, section: 0))! as! IntroPagesCell
        selectAllIndustries(cell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}




extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

extension UICollectionView {

    /// Iterates through all sections & items and selects them.
    func selectAll(animated: Bool) {
        (0..<numberOfSections).compactMap { (section) -> [IndexPath]? in
            return (0..<numberOfItems(inSection: section)).compactMap({ (item) -> IndexPath? in
                return IndexPath(item: item, section: section)
            })
            }.flatMap { $0 }.forEach { (indexPath) in
                selectItem(at: indexPath, animated: true, scrollPosition: [])
        }

    }

    /// Deselects all selected cells.
    func deselectAll(animated: Bool) {
        indexPathsForSelectedItems?.forEach({ (indexPath) in
            deselectItem(at: indexPath, animated: animated)
        })
    }

}
