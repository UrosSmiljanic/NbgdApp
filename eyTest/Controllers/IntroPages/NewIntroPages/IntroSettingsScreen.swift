//
//  IntroSettingsScreen.swift
//  eyTest
//
//  Created by Uros Smiljanic on 26/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class IntroSettingsScreen: UIViewController {

    let introThumbails = ["intro1", "intro2", "intro3"]
    let introEnglishTitles = ["What application offers", "Terms & Conditions", "Push notifications"]
    let introSerbianTitles = ["Шта апликација нуди", "Услови коришћења", "Push нотификације"]
    let introNavigationThumbail = ["settings", "file", "bell", "bullhorn"]
    var errorTitle = ""
    var errorMessage = ""

    var defaultLanguage = "en"
    let defaults = UserDefaults.standard
    var url = ""
    var collectionView: UICollectionView!
    var industries: Industries?

    var selectedIndustries: Array = [String]()

    private let cellId = "cell"

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "DFDFDF").cgColor

        return view
    }()

    let introNavigation: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "bullhorn")
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.text = "What application offers"
        return label
    }()

    let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "By selecting the industry, you filter the news and articles that you will receive about the selected industry."
        return label
    }()

    let settingsTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.text = "Choose industry"
        return label
    }()

    let chooseAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "DFDFDF")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(selectAllIndustries), for: .touchUpInside)

        return button
    }()

    var isIndustrySelected = false

    @objc func selectAllIndustries() {

        chooseAllButton.backgroundColor = UIColor(hexString: "FEE433")

        for i in 0..<collectionView.numberOfSections {
            for j in 0..<collectionView.numberOfItems(inSection: i) {
                collectionView.selectItem(at: IndexPath(row: j, section: i), animated: false, scrollPosition: [])
                let selectedCell:IndustriesToChoose = collectionView.cellForItem(at: IndexPath(row: j, section: i))! as! IndustriesToChoose

                if isIndustrySelected {
                    selectedCell.checkMark.isHidden = true

                    selectedCell.cellView.backgroundColor = UIColor(hexString: "DFDFDF")

                    self.selectedIndustries.removeAll()
                    chooseAllButton.backgroundColor = UIColor(hexString: "DFDFDF")

                } else {
                    selectedCell.checkMark.isHidden = false

                    selectedCell.cellView.backgroundColor = UIColor(hexString: "#FEE433")

                    if let id = industries?.entity?[IndexPath(row: j, section: i).row].id {
                        self.selectedIndustries.append(id)
                    }
                }

            }
        }

        isIndustrySelected = !isIndustrySelected

    }

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

    @objc func handleNextPage() {
        if selectedIndustries.count != 0 {
            defaults.set(selectedIndustries, forKey: "ChossenIndustries")
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        defaultLanguage = defaults.string(forKey: "DefaultLanguage") ?? "en"

        if defaultLanguage == "sr" {
            errorMessage = "Молимо изаберите минимум једну индустрију како бисте покренули апликацију"
            errorTitle = "Дошло је до грешке"

            infoLabel.text = "Одабиром индустрије филтрирате вести и чланке које ћете примати везано за изабрану индустрију."
            titleLabel.text = "Изабери индустрије"
            chooseAllButton.setTitle("Изабери све индустрије", for: .normal)

            nextButton.setTitle("Покрени апликацију", for: .normal)
        } else {
            errorMessage = "Please select at least one industry to run the application"
            errorTitle = "An error has occurred"

            infoLabel.text = "By selecting the industry, you filter the news and articles that you will receive about the selected industry."
            titleLabel.text = "Choose industry"
            chooseAllButton.setTitle("Choose all industries", for: .normal)

            nextButton.setTitle("Run the application", for: .normal)
        }



        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)

        self.showSpinner(onView: self.view)

        let industriesUrl = "http://ey.nbgcreator.com/api/news/categories?lang=\(defaultLanguage)&parent=4"

        fetchGenericData(urlString: industriesUrl) { (data: Industries?, err) in
            if err != nil {
                let vc = BaseViewController()
                vc.showErrorMessage()
                return
            }
            self.industries = data
            DispatchQueue.main.async {
                self.setupView()
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }

        setupCollectionView()

    }

    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(IndustriesToChoose.self, forCellWithReuseIdentifier: cellId)
        collectionView.allowsMultipleSelection = true
    }

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {

        if (sender.direction == .right) {

            let nextVc  = IntroPushNotificatrionsScreen()
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            present(nextVc, animated: false, completion: nil)

        }
    }

    func setupView() {

        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 12, right: 10))

        containerView.addSubview(introNavigation)
        introNavigation.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailling: containerView.trailingAnchor, padding: .init(top: 3, left: 0, bottom: 0, right: 0))
        introNavigation.layer.zPosition = 1

        containerView.addSubview(infoLabel)
        infoLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailling: containerView.trailingAnchor, padding: .init(top: 80, left: 12, bottom: 0, right: 12))

        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: infoLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailling: containerView.trailingAnchor, padding: .init(top: 50, left: 12, bottom: 0, right: 12))

        containerView.addSubview(chooseAllButton)
        chooseAllButton.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailling: containerView.trailingAnchor, padding: .init(top: 50, left: 12, bottom: 0, right: 12), size: .init(width: containerView.frame.width - 24, height: 50))


        containerView.addSubview(collectionView)
        collectionView.anchor(top: chooseAllButton.bottomAnchor, leading: chooseAllButton.leadingAnchor, bottom: containerView.bottomAnchor, trailling: chooseAllButton.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0))

        view.addSubview(nextButton)
        nextButton.anchor(top: containerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: view.frame.width - 24, height: 50))
    }

}

extension IntroSettingsScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return industries?.entity?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IndustriesToChoose
        if let title = industries?.entity?[indexPath.item].name {
            cell.industryTitle.text = title
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10) / 2, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell:IndustriesToChoose = collectionView.cellForItem(at: indexPath)! as! IndustriesToChoose

        selectedCell.checkMark.isHidden = false

        selectedCell.cellView.backgroundColor = UIColor(hexString: "#FEE433")

        selectedIndustries.append((industries?.entity?[indexPath.item].id)!)

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cellToDeselect:IndustriesToChoose = collectionView.cellForItem(at: indexPath)! as! IndustriesToChoose

        cellToDeselect.cellView.backgroundColor = UIColor(hexString: "#DFDFDF")
        cellToDeselect.checkMark.isHidden = true

        if let id = industries?.entity?[indexPath.item].id {
            self.selectedIndustries = selectedIndustries.filter {$0 != id}
        }
    }
}
