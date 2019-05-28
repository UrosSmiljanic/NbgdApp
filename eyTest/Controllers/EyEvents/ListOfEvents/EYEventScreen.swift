//
//  EYEventScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 04/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class EYEventScreen: BaseViewController {

    let serbianMonths = ["Јануар", "Фебруар", "Март", "Април", "Мај", "Јун", "Јул", "Август", "Септембар", "Октобар", "Новембар", "Децембар"]
    let englishMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]


    var currentYear = 2019
    var currentMonth = 3

    var isFromCalendar = false

    var tableView: UITableView!
    let cellId = "tableCell"
    var listOfEvents: EYEvents?
    var listOfEventsFilter: EuEventsList?
    var pageTitle: String?

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
        screen.isFrom = "eyEvents"
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

        var url = "http://ey.nbgcreator.com/api/news/events?lang=\(defaultLanguage)"

        if isFromCalendar {
           // isFromCalendar = false
            url = "http://ey.nbgcreator.com/api/news/filter_events?lang=\(defaultLanguage)&date=\(currentYear)-\(currentMonth)"
            
            fetchGenericData(urlString: url) { (data: EuEventsList?, error) in
                if error != nil {
                    self.showErrorMessage()
                    return
                }
                self.listOfEventsFilter = data
                DispatchQueue.main.async {
                    if self.defaultLanguage == "sr" {
                        self.yearLabel.text = "\(self.serbianMonths[self.currentMonth - 1]) \(self.currentYear)"//String(self.currentYear)
                    } else {
                        self.yearLabel.text = "\(self.englishMonths[self.currentMonth - 1]) \(self.currentYear)"//String(self.currentYear)
                    }
                    self.titleLabel.text = self.pageTitle
                    self.setupViews()
                    self.setupTableView()
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            }
        } else {
            fetchGenericData(urlString: url) { (data: EYEvents?, error) in
                if error != nil {
                    self.showErrorMessage()
                    return
                }
                self.listOfEvents = data
                DispatchQueue.main.async {
                    if self.defaultLanguage == "sr" {
                        self.yearLabel.text = "\(self.serbianMonths[self.currentMonth - 1]) \(self.currentYear)"//String(self.currentYear)
                    } else {
                        self.yearLabel.text = "\(self.englishMonths[self.currentMonth - 1]) \(self.currentYear)"//String(self.currentYear)
                    }

                    self.titleLabel.text = self.pageTitle
                    self.setupViews()
                    self.setupTableView()
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
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
    }

    let leftArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "leftArrow"), for: .normal)
        //button.addTarget(self, action: #selector(decreaseYear), for: .touchUpInside)

        return button
    }()

    @objc func decreaseYear() {
        currentYear = currentYear - 1
        yearLabel.text = String(currentYear)
    }

    let rightArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
       // button.addTarget(self, action: #selector(increaseYear), for: .touchUpInside)

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
        headerContainerView.anchor(top: leftArrowButton.topAnchor, leading: headerView.leadingAnchor, bottom: leftArrowButton.bottomAnchor, trailling: nil, padding: .init(top: 0, left: (screensize.width / 2) - 65, bottom: 0, right: 0),size: .init(width: 130, height: 0))

        headerContainerView.addSubview(yearLabel)
        yearLabel.fillSuperView()
    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EYEventCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .clear
        self.view.addSubview(tableView)

        tableView.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
    }
}

extension EYEventScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isFromCalendar {
            return listOfEventsFilter?.entity.completed.count ?? 0
        }

        return listOfEvents?.entity?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EYEventCell

        if isFromCalendar {
            cell.dateLabel.text = listOfEventsFilter?.entity.completed[indexPath.row].publishDate
            cell.titleLabel.text = listOfEventsFilter?.entity.completed[indexPath.row].title

            return cell
        }
        cell.dateLabel.text = listOfEvents?.entity?[indexPath.row].publishDate
        cell.titleLabel.text = listOfEvents?.entity?[indexPath.row].title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if isFromCalendar {
            let screen = SingleEventScreen()
            screen.pageTitle = self.pageTitle
            screen.id = (listOfEventsFilter?.entity.completed[indexPath.row].id)!
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        } else {
            let screen = SingleEventScreen()
            screen.pageTitle = self.pageTitle
            screen.id = (listOfEvents?.entity?[indexPath.row].id)!
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        }


    }


}
