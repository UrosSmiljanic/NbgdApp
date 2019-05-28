//
//  CurrentSettingsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 12/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class CurrentSettingsScreen: UIViewController {

    let cellId = "myCell"
    let screensize: CGRect = UIScreen.main.bounds

    let defaults = UserDefaults.standard
    var collectionView: UICollectionView!
    var defaultLanguage = "en"
    var isPushNotificationActive = true
    var pushNotificationTextString =  String()
    var industriesToSelect: Industries?
    var isIndustrySelected = false
    var selectedIndustry: Array = [String]()
    var errorTitle = ""
    var errorMessage = ""

    let backToTheAppButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "FEE433")
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)

        button.addTarget(self, action: #selector(exitSettings), for: .touchUpInside)

        return button
    }()

    @objc func exitSettings() {
        let vc = UINavigationController(rootViewController: HomeScreen())
        present(vc, animated: true, completion: nil)
    }

    let headerView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "settings-img")
        view.contentMode = .scaleAspectFit

        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let changeLanguageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "DFDFDF")
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)

        button.addTarget(self, action: #selector(handleChangeLanguage), for: .touchUpInside)

        return button
    }()

    let selectedIndustriesButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "DFDFDF")
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)

        button.addTarget(self, action: #selector(handleSelectIndustries), for: .touchUpInside)

        return button
    }()

    let selectPushNotificationsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "DFDFDF")
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)

        button.addTarget(self, action: #selector(handlePushNotification), for: .touchUpInside)

        return button
    }()

    let pushNotificationText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let checkedBox: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.frame.size = CGSize(width: 35, height: 35)

        return view
    }()

    let checkedBoxImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "checkMark")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.isHidden = true

        return view
    }()

    let pushNotificationTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    fileprivate func setupViews() {
        view.addSubview(backToTheAppButton)
        backToTheAppButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12), size: .init(width: 0, height: 50))

        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 200))

        view.addSubview(titleLabel)
        titleLabel.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 70))

        view.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 70))

        view.addSubview(changeLanguageButton)
        changeLanguageButton.anchor(top: subtitleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))

        view.addSubview(selectedIndustriesButton)
        selectedIndustriesButton.anchor(top: changeLanguageButton.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))

        view.addSubview(selectPushNotificationsButton)
        selectPushNotificationsButton.anchor(top: selectedIndustriesButton.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 125))

        selectPushNotificationsButton.addSubview(pushNotificationText)
        pushNotificationText.anchor(top: nil, leading: selectPushNotificationsButton.leadingAnchor, bottom: selectPushNotificationsButton.bottomAnchor, trailling: selectPushNotificationsButton.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12))

        let testView = UIView()

        testView.addSubview(checkedBox)
        testView.addSubview(pushNotificationTitle)

        checkedBox.anchor(top: testView.topAnchor, leading: nil, bottom: nil, trailling: nil, size: .init(width: 35, height: 35))

        pushNotificationTitle.anchor(top: testView.topAnchor, leading: checkedBox.trailingAnchor, bottom: nil, trailling: testView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0), size: .init(width: 0, height: 35))


        let size = pushNotificationTextString.size(withAttributes:[.font: UIFont(name: "EYInterstate-Bold", size: 20)!])
        

        selectPushNotificationsButton.addSubview(testView)
        testView.anchor(top: selectPushNotificationsButton.topAnchor, leading: selectPushNotificationsButton.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 12, left: (screensize.width - 24 - checkedBox.frame.width - size.width - 12) / 2, bottom: 0, right: 0), size: .init(width: checkedBox.frame.width + size.width + 12, height: 35))

        checkedBox.addSubview(checkedBoxImage)
        checkedBoxImage.fillSuperView()
    }

    @objc func handlePushNotification() {
        isPushNotificationActive = !isPushNotificationActive
        checkedBoxImage.isHidden = isPushNotificationActive ? false : true

    }

    @objc func handleChangeLanguage() {
        if defaultLanguage == "sr" {
            let alert = UIAlertController(title: "Изаберите језик:", message: nil, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Српски", style: .default, handler: { action in
                self.defaults.set("sr", forKey: "DefaultLanguage")
                self.defaults.synchronize()
                self.changeLanguageButton.setTitle("Српски", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "Енглески", style: .default, handler: { action in
                self.defaults.set("en", forKey: "DefaultLanguage")
                self.defaults.synchronize()
                self.changeLanguageButton.setTitle("Енглески", for: .normal)

            }))

            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Select language:", message: nil, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Serbian", style: .default, handler: { action in
                self.defaults.set("sr", forKey: "DefaultLanguage")
                self.defaults.synchronize()
                self.changeLanguageButton.setTitle("Serbian", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "English", style: .default, handler: { action in
                self.defaults.set("en", forKey: "DefaultLanguage")
                self.defaults.synchronize()
                self.changeLanguageButton.setTitle("English", for: .normal)
            }))

            self.present(alert, animated: true)
        }
    }

    @objc func handleSelectIndustries() {
        handleSelectedIndustries()
    }

    @objc func handleSelectAllIndustries() {

        for i in 0..<collectionView.numberOfSections {
            for j in 0..<collectionView.numberOfItems(inSection: i) {
                collectionView.selectItem(at: IndexPath(row: j, section: i), animated: false, scrollPosition: [])
                let selectedCell:IndustriesToChoose = collectionView.cellForItem(at: IndexPath(row: j, section: i))! as! IndustriesToChoose

                if isIndustrySelected {
                    selectedCell.checkMark.isHidden = true

                    selectedCell.cellView.backgroundColor = UIColor(hexString: "DFDFDF")

                    self.selectedIndustry.removeAll()

                } else {
                    selectedCell.checkMark.isHidden = false

                    selectedCell.cellView.backgroundColor = UIColor(hexString: "#FEE433")

                    if let id = industriesToSelect?.entity?[IndexPath(row: j, section: i).row].id {
                        self.selectedIndustry.append(id)
                    }
                }

            }
        }

        isIndustrySelected = !isIndustrySelected
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        defaultLanguage = defaults.string(forKey: "DefaultLanguage") ?? "en"

        if defaultLanguage == "en" {
            titleLabel.text = "Your current settings"
            subtitleLabel.text = "You can see and edit your current settings by clicking on √"
            changeLanguageButton.setTitle("English", for: .normal)
            selectedIndustriesButton.setTitle("Selected industries", for: .normal)
            pushNotificationText.text = "Keep up with current affairs and changes in tax regulations. You can always turn this function off or on."
            backToTheAppButton.setTitle("Run the application", for: .normal)
            pushNotificationTitle.text = "Push notifications"
            pushNotificationTextString = "Push notifications"
        } else {
            titleLabel.text = "Ваша тренутна подешавања"
            subtitleLabel.text = "Ваша тренутна подешавања можете видети и изменити кликом на √"
            changeLanguageButton.setTitle("Српски", for: .normal)
            selectedIndustriesButton.setTitle("Изабране индустрије", for: .normal)
            pushNotificationText.text = "Будите у току са актуелностима и изменама пореских прописа. Ову функцију увек можете искључити или укључити."
            backToTheAppButton.setTitle("Покрени апликацију", for: .normal)
            pushNotificationTitle.text = "Push нотификације"
            pushNotificationTextString = "Push нотификације"
        }

        setupViews()

        checkedBoxImage.isHidden = isPushNotificationActive ? false : true

        setupCollectionView()

        let industriesUrl = "http://ey.nbgcreator.com/api/news/categories?lang=\(defaultLanguage)&parent=4"

        fetchGenericData(urlString: industriesUrl) { (data: Industries?, err) in
            if err != nil {
                let vc = BaseViewController()
                vc.showErrorMessage()
                return
            }
            self.industriesToSelect = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()

            }
        }
    }

    let selectedIndustriesView = UIView()

    func handleSelectedIndustries() {
        if let window = UIApplication.shared.keyWindow {

            selectedIndustriesView.backgroundColor = UIColor(white: 0, alpha: 0.9)
            //            selectedIndustriesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissSelectedIndustries)))

            window.addSubview(selectedIndustriesView)

            selectedIndustriesView.frame = window.frame
            selectedIndustriesView.alpha = 0

            UIView.animate(withDuration: 0.5) {

                self.selectedIndustriesView.alpha = 1
            }
        }

        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "EYInterstate-Bold", size: 20)
            label.numberOfLines = 2
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .white

            return label
        }()

        let chooseAllButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(hexString: "DFDFDF")
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.setTitle("Choose all industries", for: .normal)

            button.addTarget(self, action: #selector(handleSelectAllIndustries), for: .touchUpInside)

            return button
        }()

        let confirmButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(hexString: "FEE433")
            button.setTitleColor(.white, for: .normal)
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
            button.setTitleColor(.black, for: .normal)

            button.addTarget(self, action: #selector(handleDismissSelectedIndustries), for: .touchUpInside)

            return button
        }()

        if defaultLanguage == "sr" {
            errorMessage = "Молимо изаберите минимум једну индустрију како бисте покренули апликацију"
            errorTitle = "Дошло је до грешке"
            titleLabel.text = "Изаберите индустрије"
            confirmButton.setTitle("Потврдите", for: .normal)
        } else {
            errorMessage = "Please select at least one industry to run the application"
            errorTitle = "An error has occurred"
            titleLabel.text = "Choose industry"
            chooseAllButton.setTitle("Choose all industries", for: .normal)
            confirmButton.setTitle("Confirm", for: .normal)
        }

        selectedIndustriesView.addSubview(titleLabel)
        titleLabel.anchor(top: selectedIndustriesView.topAnchor, leading: selectedIndustriesView.leadingAnchor, bottom: nil, trailling: selectedIndustriesView.trailingAnchor, padding: .init(top: 150, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 70))

        selectedIndustriesView.addSubview(chooseAllButton)
        chooseAllButton.anchor(top: titleLabel.bottomAnchor, leading: selectedIndustriesView.leadingAnchor, bottom: nil, trailling: selectedIndustriesView.trailingAnchor, padding: .init(top: 50, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))

        selectedIndustriesView.addSubview(collectionView)
        collectionView.anchor(top: chooseAllButton.bottomAnchor, leading: selectedIndustriesView.leadingAnchor, bottom: selectedIndustriesView.bottomAnchor, trailling: selectedIndustriesView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

        selectedIndustriesView.addSubview(confirmButton)
        confirmButton.anchor(top: nil, leading: selectedIndustriesView.safeAreaLayoutGuide.leadingAnchor, bottom: selectedIndustriesView.safeAreaLayoutGuide.bottomAnchor, trailling: selectedIndustriesView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12), size: .init(width: 0, height: 50))
    }

    @objc func handleDismissSelectedIndustries() {

        if selectedIndustry.count != 0 {
            defaults.set(selectedIndustry, forKey: "ChossenIndustries")
            defaults.synchronize()

            UIView.animate(withDuration: 0.5) {

                self.selectedIndustriesView.alpha = 0
            }
        } else {

            let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)

        }

    }


    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IndustriesToChoose.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
    }

}

extension CurrentSettingsScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return industriesToSelect?.entity?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IndustriesToChoose

        if let title = industriesToSelect?.entity?[indexPath.item].name {
            cell.industryTitle.text = title
        }

        if selectedIndustry.contains((industriesToSelect?.entity?[indexPath.item].id)!) {
            cell.checkMark.isHidden = false
            cell.cellView.backgroundColor = UIColor(hexString: "#FEE433")
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

        if let id = industriesToSelect?.entity?[indexPath.item].id {
            self.selectedIndustry.append(id)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cellToDeselect:IndustriesToChoose = collectionView.cellForItem(at: indexPath)! as! IndustriesToChoose

        cellToDeselect.cellView.backgroundColor = UIColor(hexString: "#DFDFDF")
        cellToDeselect.checkMark.isHidden = true

        if let id = industriesToSelect?.entity?[indexPath.item].id {
            self.selectedIndustry = selectedIndustry.filter {$0 != id}
        }
    }

}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
