//
//  BaseViewController.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var defaultLanguage = "en"
    let defaults = UserDefaults.standard

    var choosenIndustry: Array = [String]()

    let screensize: CGRect = UIScreen.main.bounds

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(self, action: #selector(handleGoBackAction), for: .touchUpInside)
        return button
    }()
    
    @objc func handleGoBackAction() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        defaultLanguage = defaults.string(forKey: "DefaultLanguage") ?? "en"
        choosenIndustry = defaults.array(forKey: "ChossenIndustries") as? [String] ?? [String]()
        
        self.showSpinner(onView: self.view)
        
        setupNavigationBar()
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 20, left: 12, bottom: 0, right: 0), size: .init(width: 30, height: 30))
        
        if self is HomeScreen {
            backButton.isHidden = true
        } else {
            backButton.isHidden = false
            backButton.layer.zPosition = 1
        }

        view.addSubview(errorMessage)
        errorMessage.fillSuperView()
        //        errorMessage.layer.zPosition = 1
        errorMessage.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupNavigationBar() {
        
        setNeedsStatusBarAppearanceUpdate()
        
        let menuImage    = UIImage(named: "menu")!
        let searchImage  = UIImage(named: "search")!
        let contactImage  = UIImage(named: "envelope")!
        
        let menuButton   = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(handleMenuBtnPressed))
        let searchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(handleSearchScreen))
        let contactButton = UIBarButtonItem(image: contactImage,  style: .plain, target: self, action: #selector(handleShowingContactScreen))
        
        
        navigationItem.rightBarButtonItems = [menuButton, searchButton, contactButton]
        
        let homeImage = UIImage(named: "logo")!
        
        let homeButton = UIBarButtonItem.itemWith(colorfulImage: homeImage, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = homeButton
        //        navigationController?.navigationBar.backgroundColor = UIColor(hexString: "323334")

    }

    let blackView = UIView()
    let infoPopUpView = UIView()

    @objc func handleAboutUsPressed() {
        let screen = GridIconScreen()
        screen.submenu = true
        let vc = UINavigationController(rootViewController: screen)

        present(vc, animated: true) {
            self.handleDismiss()
        }
    }

    @objc func handleCurrentSettings() {
        let screen = CurrentSettingsScreen()
        screen.selectedIndustry = choosenIndustry
        present(screen, animated: true) {
            self.handleDismiss()
        }

    }

    @objc func handleFaqPressed() {
        let screen = ExpandableListScreen()

        screen.isFaqList = true

        if defaultLanguage == "sr" {
            screen.pageTitle = "Честа питања o апликацији"
        } else {
            screen.pageTitle = "FAQ"
        }

        let vc = UINavigationController(rootViewController: screen)

        present(vc, animated: true) {
            self.handleDismiss()
        }
    }

    fileprivate func setupBlackView() {

        let topSeperator: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        let settingsButton: UIButton = {
            let button = UIButton()
            button.setTitle("Podesavanja", for: .normal)
            button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

            button.addTarget(self, action: #selector(handleCurrentSettings), for: .touchUpInside)

            return button
        }()

        let firstSeperator: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        let faqButton: UIButton = {
            let button = UIButton()
            button.setTitle("Cesta Pitanja", for: .normal)
            button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

            button.addTarget(self, action: #selector(handleFaqPressed), for: .touchUpInside)

            return button
        }()

        let secondSeperator: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        let aboutUsButton: UIButton = {
            let button = UIButton()
            button.setTitle("O kompaniji", for: .normal)
            button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

            button.addTarget(self, action: #selector(handleAboutUsPressed), for: .touchUpInside)

            return button
        }()



        let bottomSeperator: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        let yellowMenu: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "yellowMenu")
            view.clipsToBounds = true
            view.contentMode = .scaleAspectFit
            return view
        }()

        if defaultLanguage == "sr" {
            settingsButton.setTitle("Подешавања", for: .normal)
            faqButton.setTitle("Честа питања", for: .normal)
            aboutUsButton.setTitle("О Kомпанији", for: .normal)
        } else {
            settingsButton.setTitle("Settings", for: .normal)
            faqButton.setTitle("FAQ", for: .normal)
            aboutUsButton.setTitle("Info", for: .normal)
        }

        blackView.addSubview(yellowMenu)
        yellowMenu.anchor(top: blackView.topAnchor, leading: nil, bottom: nil, trailling: blackView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 12), size: .init(width: 30, height: 30))

        blackView.addSubview(topSeperator)
        topSeperator.anchor(top: yellowMenu.bottomAnchor, leading: blackView.leadingAnchor, bottom: nil, trailling: blackView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 2))

        blackView.addSubview(settingsButton)
        settingsButton.anchor(top: topSeperator.bottomAnchor, leading: blackView.leadingAnchor, bottom: nil, trailling: blackView.trailingAnchor, size: .init(width: 0, height: 60))

        blackView.addSubview(firstSeperator)
        firstSeperator.anchor(top: settingsButton.bottomAnchor, leading: blackView.leadingAnchor, bottom: nil, trailling: blackView.trailingAnchor, size: .init(width: 0, height: 2))

        blackView.addSubview(faqButton)
        faqButton.anchor(top: firstSeperator.bottomAnchor, leading: blackView.leadingAnchor, bottom: nil, trailling: blackView.trailingAnchor, size: .init(width: 0, height: 60))

        blackView.addSubview(secondSeperator)
        secondSeperator.anchor(top: faqButton.bottomAnchor, leading: blackView.leadingAnchor, bottom: nil, trailling: blackView.trailingAnchor, size: .init(width: 0, height: 2))

        blackView.addSubview(aboutUsButton)
        aboutUsButton.anchor(top: secondSeperator.bottomAnchor, leading: blackView.leadingAnchor, bottom: nil, trailling: blackView.trailingAnchor, size: .init(width: 0, height: 60))

        blackView.addSubview(bottomSeperator)
        bottomSeperator.anchor(top: aboutUsButton.bottomAnchor, leading: blackView.leadingAnchor, bottom: nil, trailling: blackView.trailingAnchor, size: .init(width: 0, height: 2))
    }


    @objc func handleMenuBtnPressed() {
        if let window = UIApplication.shared.keyWindow {

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.85)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            window.addSubview(blackView)

            blackView.frame = window.frame
            blackView.alpha = 0

            setupBlackView()

            UIView.animate(withDuration: 0.5) {

                self.blackView.alpha = 1
            }
        }
    }

    @objc func handleSearchScreen() {

        let screen = SearchScreen()
        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: false, completion: nil)
    }

    @objc func handleDismissSearch() {
        UIView.animate(withDuration: 0.5) {

            self.infoPopUpView.alpha = 0
        }
    }

    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {

            self.blackView.alpha = 0
        }
    }
    
    @objc func handleShowingContactScreen() {
        if self is ContactScreen{
            
        } else {
            let vc = UINavigationController(rootViewController: ContactScreen())
            
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func handleHomeButton() {
        
        if self is HomeScreen {

        } else {
            
            let vc = UINavigationController(rootViewController: HomeScreen())
            
            present(vc, animated: true, completion: nil)
        }
        
    }

    let errorMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .white

        return label
    }()

    func showErrorMessage() {
        DispatchQueue.main.async {

            if self.defaultLanguage == "sr" {
                self.errorMessage.text = "Извините, дошло је до грешке. Молимо Вас покушајте поново касније..."
            } else {
                self.errorMessage.text = "Apologies, something went wrong. Please try again later..."
            }

            self.view.addSubview(self.errorMessage)
            self.errorMessage.fillSuperView()
            self.removeSpinner()
        }

    }

    func showInfoView(title: String, text: String) {
        if let window = UIApplication.shared.keyWindow {

            infoPopUpView.backgroundColor = UIColor(white: 0, alpha: 0.9)
            infoPopUpView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissSearch)))

            window.addSubview(infoPopUpView)

            infoPopUpView.frame = window.frame
            infoPopUpView.alpha = 0

            UIView.animate(withDuration: 0.5) {

                self.infoPopUpView.alpha = 1
            }
        }

        let infoThumbail: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "info")
            view.contentMode = .scaleAspectFill
            return view
        }()

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

        let dismissButton: UIButton = {
            let button = UIButton()
            button.isUserInteractionEnabled = false
            button.setImage(#imageLiteral(resourceName: "exit"), for: .normal)
            return button
        }()

        let textLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "EYInterstate-LighBold", size: 17)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .white

            return label
        }()

        titleLabel.text = title
        textLabel.text = text

        infoPopUpView.addSubview(infoThumbail)
        infoThumbail.anchor(top: infoPopUpView.topAnchor, leading: infoPopUpView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 96, left: 24, bottom: 0, right: 0), size: .init(width: 50, height: 50))

        infoPopUpView.addSubview(titleLabel)
        titleLabel.anchor(top: infoThumbail.topAnchor, leading: infoThumbail.trailingAnchor, bottom: nil, trailling: infoPopUpView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 62), size: .init(width: 0, height: 50))

        infoPopUpView.addSubview(dismissButton)
        dismissButton.anchor(top: nil, leading: nil, bottom: titleLabel.topAnchor, trailling: infoPopUpView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 24), size: .init(width: 30, height: 30))

        infoPopUpView.addSubview(textLabel)
        textLabel.anchor(top: titleLabel.bottomAnchor, leading: infoPopUpView.leadingAnchor, bottom: nil, trailling: infoPopUpView.trailingAnchor, padding: .init(top: 48, left: 24, bottom: 0, right: 24))

    }

    let sortNewsView = UIView()

    fileprivate func setSortNewsView() {
        let topSeperator: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        let settingsButton: UIButton = {
            let button = UIButton()
            button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

            button.addTarget(self, action: #selector(handleSortByNewest), for: .touchUpInside)

            return button
        }()

        let firstSeperator: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        let faqButton: UIButton = {
            let button = UIButton()
            button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

            button.addTarget(self, action: #selector(handleSortByTheLatest), for: .touchUpInside)

            return button
        }()

        let secondSeperator: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        let yellowMenu: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "sort")
            view.clipsToBounds = true
            view.contentMode = .scaleAspectFit
            return view
        }()

        if defaultLanguage == "sr" {
            settingsButton.setTitle("Поређај по најновијим", for: .normal)
            faqButton.setTitle("Поређај по најчитанијим", for: .normal)
        } else {
            settingsButton.setTitle("Sort by the latest", for: .normal)
            faqButton.setTitle("Sort by the most read", for: .normal)
        }

        sortNewsView.addSubview(yellowMenu)
        yellowMenu.anchor(top: sortNewsView.topAnchor, leading: nil, bottom: nil, trailling: sortNewsView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 12), size: .init(width: 30, height: 30))

        sortNewsView.addSubview(topSeperator)
        topSeperator.anchor(top: yellowMenu.bottomAnchor, leading: sortNewsView.leadingAnchor, bottom: nil, trailling: sortNewsView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 2))

        sortNewsView.addSubview(settingsButton)
        settingsButton.anchor(top: topSeperator.bottomAnchor, leading: sortNewsView.leadingAnchor, bottom: nil, trailling: sortNewsView.trailingAnchor, size: .init(width: 0, height: 60))

        sortNewsView.addSubview(firstSeperator)
        firstSeperator.anchor(top: settingsButton.bottomAnchor, leading: sortNewsView.leadingAnchor, bottom: nil, trailling: sortNewsView.trailingAnchor, size: .init(width: 0, height: 2))

        sortNewsView.addSubview(faqButton)
        faqButton.anchor(top: firstSeperator.bottomAnchor, leading: sortNewsView.leadingAnchor, bottom: nil, trailling: sortNewsView.trailingAnchor, size: .init(width: 0, height: 60))

        sortNewsView.addSubview(secondSeperator)
        secondSeperator.anchor(top: faqButton.bottomAnchor, leading: sortNewsView.leadingAnchor, bottom: nil, trailling: sortNewsView.trailingAnchor, size: .init(width: 0, height: 2))

    }
	
	func convertCurrencyToDouble(input: String) -> Double? {
		let correctInput = input.replacingOccurrences(of: ".", with: "")
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale(identifier: "de_DE")
		formatter.currencySymbol = ""
		formatter.maximumFractionDigits = 2
		formatter.minimumFractionDigits = 2
		return formatter.number(from: correctInput)?.doubleValue
	}

    func showSortNewsView() {

        if let window = UIApplication.shared.keyWindow {

            sortNewsView.backgroundColor = UIColor(white: 0, alpha: 0.9)
            sortNewsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissSortNewsView)))

            window.addSubview(sortNewsView)

            sortNewsView.frame = window.frame
            sortNewsView.alpha = 0

            UIView.animate(withDuration: 0.5) {

                self.sortNewsView.alpha = 1
            }
        }

        setSortNewsView()

    }

    @objc func handleSortByTheLatest() {

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sortByMostRead"), object: nil, userInfo: nil)

        self.handleDismissSortNewsView()
    }

    @objc func handleSortByNewest() {

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sortByNew"), object: nil, userInfo: nil)

        self.handleDismissSortNewsView()

    }

    @objc func handleDismissSortNewsView() {
        UIView.animate(withDuration: 0.5) {

            self.sortNewsView.alpha = 0
        }
    }

}
