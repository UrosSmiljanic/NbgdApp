//
//  PollCongratsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 07/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class PollCongratsScreen: BaseViewController {

    

    var date: String?
    var pageTitle: String?

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    let headerText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let publishDateHolder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()

    let calThumbail: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "calendar")
        view.contentMode = .scaleAspectFill
        return view
    }()

    let publishDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 15)
        label.textAlignment = .left

        return label
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LighBold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let backToPollButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

        button.addTarget(self, action: #selector(handleBackToPolls), for: .touchUpInside)

        return button
    }()

    @objc func handleBackToPolls() {
        let screen = PollListScreen()
        screen.pageTitle = pageTitle
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        removeSpinner()
        backButton.isHidden = true

        if defaultLanguage == "sr" {
            headerText.text = "Хвала на учешћу! \n Резултате ћете моћи да видите по истеку анкете. \n Статистика резултата ће Вам стићи нотификацијом."
            textLabel.text = "Ова анкета је анонимна. Ваш глас ће бити сабран са осталим гласовима и резултат ће бити приказан на нивоу статистичког узорка."
            backToPollButton.setTitle("Врати се на анкету", for: .normal)
        } else {
            headerText.text = "Thank you for participating!! \n You will be able to see the results after the survey is finalized. \n You will receive the statistical results via notification."
            textLabel.text = "This survey is anonimous and result will be presented at the level of statistical pool. Results will be used only for general information about public opinion related to the specific survey topics"
            backToPollButton.setTitle("Back to the survey", for: .normal)
        }

        publishDate.text = date

        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 200))

        headerView.addSubview(headerText)
        headerText.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailling: headerView.trailingAnchor, padding: .init(top: 24, left: 12, bottom: 0, right: 12))

        view.addSubview(publishDateHolder)
        publishDateHolder.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 175, left: (screensize.width / 2) - 125, bottom: 0, right: 0), size: .init(width: 250, height: 50))

        publishDateHolder.addSubview(calThumbail)
        calThumbail.anchor(top: publishDateHolder.topAnchor, leading: publishDateHolder.leadingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 5, left: 24, bottom: 5, right: 0))

        publishDateHolder.addSubview(publishDate)
        publishDate.anchor(top: publishDateHolder.topAnchor, leading: calThumbail.trailingAnchor, bottom: publishDateHolder.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 5, bottom: 12, right: 0))

        view.addSubview(backToPollButton)
        backToPollButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12), size: .init(width: view.frame.width - 24, height: 50))

        view.addSubview(textLabel)
        textLabel.anchor(top: publishDateHolder.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

    }

}
