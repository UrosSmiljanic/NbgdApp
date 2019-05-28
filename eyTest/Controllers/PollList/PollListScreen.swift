//
//  PollListScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 06/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class PollListScreen: BaseViewController {

    

    var tableView: UITableView!
    let cellId = "tableCell"
    var listOfPolls: Polls?
    var pageTitle: String?
    var archiveIsOpen = false


    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "yellowinfo"), for: .normal)
        button.addTarget(self, action: #selector(openInfo), for: .touchUpInside)
        return button
    }()

    @objc func openInfo() {
        if defaultLanguage == "sr" {
            let text = "Ова анкета је анонимна. Ваш глас ће бити сабран са осталим гласовима и резултат ће бити на нивоу статистичког узорка."
            let title = "Информације о анкети"

            showInfoView(title: title, text: text)

        } else {
            let text = "This poll is anonymous. Your vote will be compiled with other votes and the result will be at the level of the statistical sample."
            let title = "Survey information"

            showInfoView(title: title, text: text)
        }
    }

    let archiveButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "archiveClosed"), for: .normal)
        button.addTarget(self, action: #selector(openArchive), for: .touchUpInside)
        return button
    }()

    @objc func openArchive() {

        archiveButton.setImage(!archiveIsOpen ? #imageLiteral(resourceName: "archiveOpen") : #imageLiteral(resourceName: "archiveClosed"), for: .normal)

        if !archiveIsOpen {

            let archiveUrl = "http://ey.nbgcreator.com/api/polls/archive?lang=\(defaultLanguage)"

            fetchGenericData(urlString: archiveUrl) { (data: Polls?, error) in
                if error != nil {
                    self.showErrorMessage()
                    return
                }
                self.listOfPolls = data
                DispatchQueue.main.async {
                    self.setupViews()
                    self.setupTableView()
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            }

            if defaultLanguage == "sr" {
                titleLabel.text = pageTitle! + "-" + "архива"
            } else {
                titleLabel.text = pageTitle! + "-" + "archive"
            }

        } else {

             let url = "http://ey.nbgcreator.com/api/polls/?lang=\(defaultLanguage)"
            
            fetchGenericData(urlString: url) { (data: Polls?, error) in
                if error != nil {
                    self.showErrorMessage()
                    return
                }
                self.listOfPolls = data
                DispatchQueue.main.async {
                    self.setupViews()
                    self.setupTableView()
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            }

            if defaultLanguage == "sr" {
                titleLabel.text = pageTitle!
            } else {
                titleLabel.text = pageTitle!
            }

        }

        upTriangle.isHidden = archiveIsOpen

        archiveIsOpen = !archiveIsOpen

    }

    let upTriangle: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "upTriangle")
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

         let url = "http://ey.nbgcreator.com/api/polls/?lang=\(defaultLanguage)"

        fetchGenericData(urlString: url) { (data: Polls?, error) in
            if error != nil {
                self.showErrorMessage()
                return
            }
            self.listOfPolls = data
            DispatchQueue.main.async {
                self.titleLabel.text = self.pageTitle
                self.setupViews()
                self.setupTableView()
                self.tableView.reloadData()
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
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 80), size: .init(width: 0, height: 70))

        view.addSubview(infoButton)
        infoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 8))



        view.addSubview(archiveButton)
        archiveButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: infoButton.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 30))

         infoButton.layer.zPosition = 1

        view.addSubview(upTriangle)
        upTriangle.anchor(top: archiveButton.bottomAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: infoButton.trailingAnchor, padding: .init(top: -16, left: 0, bottom: 0, right: 30))
        upTriangle.layer.zPosition = 1
    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EYEventCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .clear
        view.addSubview(tableView)
        tableView.layer.zPosition = 1
        tableView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
    }

}

extension PollListScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPolls?.entity?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EYEventCell

        cell.uploadImage.isHidden = true

        cell.dateLabel.text = listOfPolls?.entity?[indexPath.row].date



        cell.titleLabel.text = listOfPolls?.entity?[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !archiveIsOpen {
            let screen = PollQuestionScreen()
            screen.pageTitle = self.pageTitle
            screen.id = (listOfPolls?.entity?[indexPath.row].id)!
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        } else {
             let screen = PollsResultsScreen()
            screen.pageTitle = self.pageTitle
            screen.id = (listOfPolls?.entity?[indexPath.row].id)!
            screen.date = listOfPolls?.entity?[indexPath.row].date
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        }


    }


}
