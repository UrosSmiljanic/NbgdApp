//
//  CalendarScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 05/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class CalendarScreen: BaseViewController {

    let cellId = "myCell"
    var collectionView: UICollectionView!

    var isFrom = ""

    var currentYear = 2019
    var currentMonth = 3

    let serbianMonths = ["Јануар", "Фебруар", "Март", "Април", "Мај", "Јун", "Јул", "Август", "Септембар", "Октобар", "Новембар", "Децембар"]
    let englishMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

//    let calendarButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
//        button.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
//        return button
//    }()
//
//    @objc func openCalendar() {
//        print("Open Calendar")
//    }

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        currentYear = defaults.integer(forKey: "currentYear")
        currentMonth = defaults.integer(forKey: "currentMonth")

        setupViews()

        setupCollectionView()

        yearLabel.text = String(currentYear)

        removeSpinner()
    }
    

    func setupViews() {



        view.addSubview(pageTitleLabel)
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

//        view.addSubview(calendarButton)
//        calendarButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: pageTitleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))

        view.addSubview(headerView)
        headerView.anchor(top: pageTitleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: screensize.width, height: 60))

        setHeaderView()
    }

    let leftArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        button.addTarget(self, action: #selector(decreaseYear), for: .touchUpInside)

        return button
    }()

    @objc func decreaseYear() {
        currentYear = currentYear - 1
        yearLabel.text = String(currentYear)
    }

    let rightArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
        button.addTarget(self, action: #selector(increaseYear), for: .touchUpInside)

        return button
    }()

    @objc func increaseYear() {
        currentYear = currentYear + 1
        yearLabel.text = String(currentYear)
    }

    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75

        return label
    }()

    func setHeaderView() {

        let headerContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        headerView.addSubview(leftArrowButton)
        leftArrowButton.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 36, height: 36))

        headerView.addSubview(rightArrowButton)
        rightArrowButton.anchor(top: headerView.topAnchor, leading: nil, bottom: nil, trailling: headerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 36, height: 36))

        headerView.addSubview(headerContainerView)
        headerContainerView.anchor(top: leftArrowButton.topAnchor, leading: headerView.leadingAnchor, bottom: leftArrowButton.bottomAnchor, trailling: nil, padding: .init(top: 0, left: (screensize.width / 2) - 50, bottom: 0, right: 0),size: .init(width: 100, height: 0))

        headerContainerView.addSubview(yearLabel)
        yearLabel.fillSuperView()
    }

    fileprivate func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: cellId)
        //  collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.backgroundColor = UIColor.white

        view.addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }

}

extension CalendarScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.width - 20) / 2
        let height : CGFloat = (collectionView.frame.width-20)/5
        return CGSize(width: width, height: height)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CalendarCell

        if defaultLanguage == "sr" {
            cell.monthTitle.text = serbianMonths[indexPath.item]
        } else {
            cell.monthTitle.text = englishMonths[indexPath.item]
        }


        if indexPath.item == currentMonth {
            cell.cellView.backgroundColor = UIColor(hexString: "FEE433")
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFrom == "eyEvents" {
            let screen = EYEventScreen()
            screen.pageTitle = pageTitleLabel.text
            screen.currentYear = currentYear
            screen.currentMonth = indexPath.item + 1
            screen.isFromCalendar = true
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        } else {
            let screen = TaxCalendarScreen()
            screen.pageTitle = pageTitleLabel.text
            screen.currentYear = currentYear
            screen.currentMonth = indexPath.item + 1
            //screen.isFromCalendar = true
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        }

    }
}
