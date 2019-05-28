//
//  IntroOffersScreen.swift
//  eyTest
//
//  Created by Uros Smiljanic on 26/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class IntroOffersScreen: UIViewController {

    let introThumbails = ["intro1", "intro2", "intro3"]
    let introEnglishTitles = ["What application offers", "Terms & Conditions", "Push notifications"]
    let introSerbianTitles = ["Шта апликација нуди", "Услови коришћења", "Push нотификације"]
    let introNavigationThumbail = ["settings", "file", "bell", "bullhorn"]
    var errorTitle = ""
    var errorMessage = ""


    var defaultLanguage = "en"
    let defaults = UserDefaults.standard
    var url = ""

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
        view.image = #imageLiteral(resourceName: "settings")
        return view
    }()

    let thumbailView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "intro1")
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.text = "What application offers"
        return label
    }()

    let introTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .left
        return textView
    }()

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
        let nextVc  = IntroTermsAndConditionsScreen()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(nextVc, animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white


        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)

        self.showSpinner(onView: self.view)

        defaultLanguage = defaults.string(forKey: "DefaultLanguage") ?? "en"

        if defaultLanguage == "sr" {

            nextButton.setTitle("Даље", for: .normal)

            url = "http://ey.nbgcreator.com/api/config/?keys[]=mob_intro_app_sr&keys[]=mob_intro_push_sr&keys[]=mob_intro_terms_sr"
            fetchGenericData(urlString: url) { (introData: IntroPagesSr?, err) in
                if err != nil {
//                    let screen = BaseViewController()
//
//                    let vc = UINavigationController(rootViewController: screen)
//                    self.present(vc, animated: true, completion: {
//                        screen.showErrorMessage()
//                    })
                    return
                }

                DispatchQueue.main.async {
                    self.introTextView.attributedText = formatHtmlString(htmlString: introData?.entity?.mobIntroAppSr ?? "<html><body> </body></html>")
                    self.titleLabel.text = "Шта апликација нуди"
                    self.setupView()
                    self.removeSpinner()
                }
            }
        } else {

            nextButton.setTitle("Next", for: .normal)

            url = "http://ey.nbgcreator.com/api/config/?keys[]=mob_intro_app_en&keys[]=mob_intro_push_en&keys[]=mob_intro_terms_en"
            fetchGenericData(urlString: url) { (introData: IntroPagesModel?, err) in
                if err != nil {
                    let vc = BaseViewController()
                    vc.showErrorMessage()
                    return
                }
                
                DispatchQueue.main.async {
                    self.introTextView.attributedText = formatHtmlString(htmlString: introData?.entity.mobIntroAppEn ?? "<html><body> </body></html>")
                     self.titleLabel.text = "What application offers"
                    self.setupView()
                    self.removeSpinner()
                }
            }
        }

    }

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {

        if (sender.direction == .left) {

            let nextVc  = IntroTermsAndConditionsScreen()
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
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

        containerView.addSubview(thumbailView)
        thumbailView.anchor(top: introNavigation.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailling: containerView.trailingAnchor, padding: .init(top: 80, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 130))

        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: thumbailView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailling: containerView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0))

        containerView.addSubview(introTextView)
        introTextView.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailling: containerView.trailingAnchor, padding: .init(top: 50, left: 12, bottom: 12, right: 12))

        view.addSubview(nextButton)
        nextButton.anchor(top: containerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: view.frame.width - 24, height: 50))
    }

}

