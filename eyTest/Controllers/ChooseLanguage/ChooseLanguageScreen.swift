//
//  ChooseLanguageScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 25/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class ChooseLanguageScreen: UIViewController {

    let defaults = UserDefaults.standard

    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "home-bg")
        view.contentMode = .scaleToFill
        return view
    }()

    let chooseSerbianButton: UIButton = {
        let button = UIButton()
        button.setTitle("  Serbian", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left

        button.addTarget(self, action: #selector(handleChooseSerbian), for: .touchUpInside)

        return button
    }()

    @objc func handleChooseSerbian() {
        defaults.set("sr", forKey: "DefaultLanguage")
        defaults.synchronize()
        show(IntroOffersScreen(), sender: self)
    }

    let chooseSerbianButtonArrow: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowBtn")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    let chooseEnglishButton: UIButton = {
        let button = UIButton()
        button.setTitle("  English", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left

        button.addTarget(self, action: #selector(handleChooseEnglish), for: .touchUpInside)

        return button
    }()

    @objc func handleChooseEnglish() {
        defaults.set("en", forKey: "DefaultLanguage")
        defaults.synchronize()
        show(IntroOffersScreen(), sender: self)
    }

    let chooseEnglishButtonArrow: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "arrowBtn")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    fileprivate func setupView() {
        view.backgroundColor = UIColor(hexString: "dfdfdf")
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)

        view.addSubview(chooseEnglishButton)
        chooseEnglishButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: backgroundImage.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 30, right: 16), size: .init(width: 0, height: 60))

        chooseEnglishButton.addSubview(chooseEnglishButtonArrow)
        chooseEnglishButtonArrow.anchor(top: chooseEnglishButton.topAnchor, leading: nil, bottom: chooseEnglishButton.bottomAnchor, trailling: chooseEnglishButton.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 10), size: .init(width: 60, height: 40))

        view.addSubview(chooseSerbianButton)
        chooseSerbianButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: chooseEnglishButton.topAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 30, right: 16), size: .init(width: 0, height: 60))

        chooseSerbianButton.addSubview(chooseSerbianButtonArrow)
        chooseSerbianButtonArrow.anchor(top: chooseSerbianButton.topAnchor, leading: nil, bottom: chooseSerbianButton.bottomAnchor, trailling: chooseSerbianButton.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 10), size: .init(width: 60, height: 40))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }
    

}
