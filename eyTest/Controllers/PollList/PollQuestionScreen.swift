//
//  PollQuestionScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 07/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class PollQuestionScreen: BaseViewController {

    var pageTitle: String?
    var id = ""
    var questionAnswers: SingleSurvey?
    var tableView: UITableView!
    let cellId = "tableCell"


    let pageTitleLabel: UILabel = {
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
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)

    }

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "323334")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()


        let url = "http://ey.nbgcreator.com/api/polls/single/?lang=\(defaultLanguage)&id="

        fetchGenericData(urlString: url + id) { (data: SingleSurvey?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            self.questionAnswers = data
            DispatchQueue.main.async {
                self.pageTitleLabel.text = self.pageTitle
                self.dateLabel.text = data?.entity.date
                self.titleLabel.text = data?.entity.name

                self.setupViews()
                self.setupTableView()
                self.removeSpinner()
            }
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
    }

    func setupViews() {

        view.addSubview(pageTitleLabel)
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(calendarButton)
        calendarButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: pageTitleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 12))

        view.addSubview(headerView)
        headerView.anchor(top: pageTitleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: screensize.width, height: 140))

        setHeaderView()
    }

    let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.textColor = UIColor(hexString: "FEE433")
        label.textAlignment = .left

        return label
    }()

    let downloadImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "downlod")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1

        return label
    }()

    func setHeaderView() {

        headerView.addSubview(leftLineView)
        leftLineView.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 24, bottom: 12, right: 0), size: .init(width: 5, height: 0))

        headerView.addSubview(downloadImage)
        downloadImage.anchor(top: leftLineView.topAnchor, leading: nil, bottom: nil, trailling: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12), size: .init(width: 30, height: 30))

        headerView.addSubview(dateLabel)
        dateLabel.anchor(top: leftLineView.topAnchor, leading: leftLineView.trailingAnchor, bottom: nil, trailling: downloadImage.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0), size: .init(width: 0, height: 30))

        headerView.addSubview(titleLabel)
        titleLabel.anchor(top: dateLabel.bottomAnchor, leading: leftLineView.trailingAnchor, bottom: headerView.bottomAnchor, trailling: headerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 0))

        downloadImage.isHidden = true

    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PollAnswersCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .clear
        self.view.addSubview(tableView)

        tableView.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
    }

    func finishPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(Response.self, from: jsonData)

            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }



}

extension PollQuestionScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionAnswers?.entity.options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)  as!  PollAnswersCell

        if defaultLanguage == "sr" {
            let alphabet = Array("АБЦДЕФГХИЈКЛМНОПQРСТУВWXYЗ")
            cell.alphabetImage.setTitle(String(alphabet[indexPath.item]), for: .normal)
        } else {
            let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            cell.alphabetImage.setTitle(String(alphabet[indexPath.item]), for: .normal)
        }


        cell.answerLabel.text = questionAnswers?.entity.options[indexPath.item].option


        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        CommonValues.id = (self.questionAnswers?.entity.options[indexPath.item].id)!

//         vote(value: (questionAnswers?.entity.options[indexPath.item].id)!, language: defaultLanguage)

        var parameters = [String : Any]()
        parameters = [
            "lang": defaultLanguage,
            "id": (questionAnswers?.entity.options[indexPath.item].id)!
        ]



        ApiService.callPost(url: URL(string: "http://ey.nbgcreator.com/api/polls/vote")!, params: parameters, finish: finishPost)


        let screen = PollCongratsScreen()
        screen.date = questionAnswers?.entity.date
        screen.date = pageTitle
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)

//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyCongratsVC") as? SurveyCongratsVC {
//
//            self.present(viewController, animated: true) {
//                CommonValues.id = (self.questionAnswers?.entity.options[indexPath.item].id)!
//            }
//
//        }
    }

}

