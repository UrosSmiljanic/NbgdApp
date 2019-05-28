//
//  TaxCalendarScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 06/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class TaxCalendarScreen: BaseViewController {



    var currentYear = 2019
    var currentDay = 10
    var currentMonth = 12

    var tableView: UITableView!
    var collectionView: UICollectionView!
    let cellId = "tableCell"
    var pageTitle: String?

    var dates: CalendarDays?
    var calendarList: CalendarSingle?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "calendar"), for: .normal)
        button.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
        return button
    }()

    @objc func openCalendar() {
        let screen = CalendarScreen()
        screen.pageTitleLabel.text = pageTitle
        screen.isFrom = "taxCalendar"
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)

    }

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "http://ey.nbgcreator.com/api/calendar/days?date=\(currentMonth).\(currentYear)."

        fetchGenericData(urlString: url) { (data: CalendarDays?, error) in
            if error != nil {
                self.showErrorMessage()
                return
            }

            self.dates = data

            DispatchQueue.main.async {
                self.yearLabel.text = String(self.currentYear)
                self.titleLabel.text = self.pageTitle
                self.setupTableView()
                self.setupCollectionView()
                self.setupViews()
                self.tableView.reloadData()
                self.collectionView.reloadData()
                self.removeSpinner()
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }

    @objc func refresh(notification: NSNotification) {
        self.tableView?.reloadData()
    }
    

    func setupViews() {

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(calendarButton)
        calendarButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))

        view.addSubview(headerView)
        headerView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: screensize.width, height: 60))
        setHeaderView()

        collectionView.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: nil,size: .init(width: screensize.width / 3, height: 0))

        tableView.anchor(top: headerView.bottomAnchor, leading: collectionView.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)
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
        layout.sectionInset.top = 12
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DatesCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white

        collectionView.layer.borderColor = UIColor(hexString: "DFDFDF").cgColor
        collectionView.layer.borderWidth = 1

        view.addSubview(collectionView)
    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CalendarTableCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .clear
        view.addSubview(tableView)

        //tableView.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
    }

}

extension TaxCalendarScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates?.entity?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DatesCell

        if let date = dates?.entity?[indexPath.item] {
            cell.dateView.setTitle(date, for: .normal)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedCell:DatesCell = collectionView.cellForItem(at: indexPath)! as! DatesCell

        selectedCell.dateView.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)

        if let date = dates?.entity?[indexPath.item] {
            fetchGenericData(urlString: "http://ey.nbgcreator.com/api/calendar/list?lang=\(defaultLanguage)&date=\(date).\(currentMonth).\(currentYear).") { (data: CalendarSingle?, error) in
                if error != nil {
                    self.showErrorMessage()
                    return
                }
                self.calendarList = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    }

}

extension TaxCalendarScreen: UITableViewDelegate, UITableViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 24, height: collectionView.frame.width - 24)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarList?.entity.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CalendarTableCell

        cell.dateLabel.text = calendarList?.entity[indexPath.item].date
        cell.titleLabel.text = calendarList?.entity[indexPath.item].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = SingleTaxCalendarScreen()
        screen.taxCalTitlLabel.text = calendarList?.entity[indexPath.item].name
        screen.id = (calendarList?.entity[indexPath.item].id)!
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }


}
