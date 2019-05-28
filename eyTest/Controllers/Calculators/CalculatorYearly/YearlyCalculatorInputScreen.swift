//
//  YearlyCalculatorInputScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 27/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class YearlyCalculatorInputScreen: BaseViewController {

    var calculationParameters: calculatorData! //= calculatorData()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "yellowinfo"), for: .normal)
        button.addTarget(self, action: #selector(handleInfoAction), for: .touchUpInside)
        return button
    }()

    let parameterContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    @objc func handleInfoAction() {
        if defaultLanguage == "sr" {
            let text = "Ова калкулација представља упрошћену верзију индикативног обрачуна пореза. Калкулација не представља порески савет и не може се користити или се на њу ослањљти за сврхе постизања договора са пореским органима, нити за друге сврхе повезане с плаћањем пореских обавеза било којег пореског обвезника."
            let title = "Корисне информације"

            showInfoView(title: title, text: text)

        } else {
            let text = "This is a simplified version of the indicative tax calculation. Calculation does not represent tax advice and can not be used or rely on it for the purpose of reaching an agreement with the tax authorities, nor for other purposes related to the payment of any taxpayers' tax liabilities."
            let title = "Useful information"

            showInfoView(title: title, text: text)
        }
    }

    let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle("Obracunaj", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 20)

        button.addTarget(self, action: #selector(handleCalculate), for: .touchUpInside)

        return button
    }()

    @objc func handleCalculate() {

        if (userInputValueTextField.text?.trimmingCharacters(in: .whitespaces) != "") && userInputFamilyMembers.text?.trimmingCharacters(in: .whitespaces) != "" {
            if calculationParameters.currency == "eur" {
                if let userInput = userInputValueTextField.text, let eurValue = eurValueTextField.text {
                    let result = Double(userInput)! * Double(eurValue)!
                    calculationParameters.userInput = String(result)
                }
            } else {
                if let userInput = userInputValueTextField.text {
                    calculationParameters.userInput = userInput
                }

            }

            if let familyNum = userInputFamilyMembers.text {
                calculationParameters.numberOfFamilyMembers = familyNum
            }

            let screen = YearlyCalculatorResultsScreen()
            screen.calculationParameters = calculationParameters
            let vc = UINavigationController(rootViewController: screen)
            present(vc, animated: true, completion: nil)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeSpinner()


        hideKeyboard()
        hideKeyboardWhenTappedAround()



        setupView()
        setLabels()


    }

    func setLabels() {

        if defaultLanguage == "sr" {

            calculateButton.setTitle("Обрачунајте", for: .normal)

            parameterTitle.text = "УНЕСИТЕ ПАРАМЕТРЕ ЗА:"
            titleLabel.text = "Калкулатор - Годишњи порез на доходак грађана"

            if calculationParameters.currency == "eur" {
                currencyLabel.text = "ЕУР"
                eurValueTextField.attributedPlaceholder = NSAttributedString(string: "  Унесите данашњи курс евра", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            } else {
                currencyLabel.text = "РСД"
            }

            switch calculationParameters.calculationType {
            case "godisnjiN":
                calculationType.text = "Нето"
                userInputValueTextField.attributedPlaceholder = NSAttributedString(string: "  Унесите износ нето накнаде на месечном нивоу", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            case "godisnjiBone":
                calculationType.text = "Бруто 1"
                userInputValueTextField.attributedPlaceholder = NSAttributedString(string: "  Унесите износ бруто 1 накнаде на месечном нивоу", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            case "godisnjiBtwo":
                calculationType.text = "Бруто 2"
                userInputValueTextField.attributedPlaceholder = NSAttributedString(string: "  Унесите износ бруто 2 накнаде на месечном нивоу", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            default:
                return
            }

            userInputFamilyMembers.attributedPlaceholder = NSAttributedString(string: "  Унесите број издржаваних чланова породице", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])

            infoText.text = "Ова калкулација представља упрошћену верзију индикативног обрачуна пореза. Калкулација не представља порески савет и не може се користити или се на њу ослањљти за сврхе постизања договора са пореским органима, нити за друге сврхе повезане с плаћањем пореских обавеза било којег пореског обвезника."

            infoTitle.text = "Корисне информације"

        } else {

            calculateButton.setTitle("Calculate", for: .normal)
            parameterTitle.text = "ENTER PARAMETERS FOR:"
            titleLabel.text = "Calculator - Annual Income Taxes of Citizens"
            if calculationParameters.currency == "eur" {
                currencyLabel.text = "EUR"
                eurValueTextField.attributedPlaceholder = NSAttributedString(string: "  Enter today's euro exchange rate", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            } else {
                currencyLabel.text = "RSD"
            }

            switch calculationParameters.calculationType {
            case "godisnjiN":
                calculationType.text = "Net"
                userInputValueTextField.attributedPlaceholder = NSAttributedString(string: "  Enter the amount of net fees at the monthly level", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            case "godisnjiBone":
                calculationType.text = "Gross 1"
                userInputValueTextField.attributedPlaceholder = NSAttributedString(string: "  Enter the amount of gross 1 fees at the monthly level", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            case "godisnjiBtwo":
                calculationType.text = "Gross 2"
                userInputValueTextField.attributedPlaceholder = NSAttributedString(string: "  Enter the amount of gross 2 fees at the monthly level", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
            default:
                return
            }

            userInputFamilyMembers.attributedPlaceholder = NSAttributedString(string: "  Enter the number of family members", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])

            infoText.text = "This is a simplified version of the indicative tax calculation. Calculation does not represent tax advice and can not be used or rely on it for the purpose of reaching an agreement with the tax authorities, nor for other purposes related to the payment of any taxpayers' tax liabilities."

            infoTitle.text = "Useful information"

        }

    }

    fileprivate func setupView() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(infoButton)
        infoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 12))

        view.addSubview(parameterContainerView)
        parameterContainerView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 108))

        setupParameterContainer()

        setupInputFields()

        setupInfoView()
    }

    let parameterTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 20)
        label.textAlignment = .center

        return label
    }()

    let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.textAlignment = .center

        return label
    }()

    let calculationType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.textAlignment = .center

        return label
    }()

    fileprivate func setupParameterContainer() {


        parameterContainerView.addSubview(parameterTitle)
        parameterTitle.anchor(top: parameterContainerView.topAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        parameterContainerView.addSubview(currencyLabel)
        currencyLabel.anchor(top: parameterTitle.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        parameterContainerView.addSubview(calculationType)
        calculationType.anchor(top: currencyLabel.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
    }

    @objc func textFieldValDidChange(_ textField: UITextField) {

//        if textField.text!.count >= 1 {
//            if let input = textField.text {
//                let number = Double(input.replacingOccurrences(of: ",", with: ""))
////                let result = numberFormatter.string(from: NSNumber(value: number!))
////                textField.text = result!
//            }
//
//        }
    }

    let userInputValueTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "  Unesite iznos bruto 1 naknade na mesecnom nivou", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .numbersAndPunctuation
        // textField.addTarget(self, action:#selector(textFieldValDidChange), for: .editingChanged)

        return textField
    }()

    let userInputFamilyMembers: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .numbersAndPunctuation
        // textField.addTarget(self, action:#selector(textFieldValDidChange), for: .editingChanged)

        return textField
    }()

    let eurValueTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "  Unesite trenutni kurs evra", attributes: [NSAttributedString.Key.font: UIFont(name: "EYInterstate-Regular", size: 15)!])
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .numbersAndPunctuation

        return textField
    }()

    fileprivate func setupInputFields() {
        view.addSubview(userInputValueTextField)
        userInputValueTextField.anchor(top: parameterContainerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 35))

        view.addSubview(userInputFamilyMembers)
        userInputFamilyMembers.anchor(top: userInputValueTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 35))

        if calculationParameters.currency == "eur" {
            view.addSubview(eurValueTextField)
            eurValueTextField.anchor(top: userInputFamilyMembers.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 35))

            view.addSubview(calculateButton)
            calculateButton.anchor(top: eurValueTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: view.frame.width - 24, height: 50))
        } else {
            view.addSubview(calculateButton)
            calculateButton.anchor(top: userInputFamilyMembers.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: view.frame.width - 24, height: 50))
        }
    }

    let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "DFDFDF")
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()

    let infoTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    let infoText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    fileprivate func setupInfoView() {

        let infoIcon: UIImageView = {
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "info")
            view.contentMode = .scaleAspectFit
            return imageView
        }()



        view.addSubview(infoView)
        infoView.anchor(top: calculateButton.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

        infoView.addSubview(infoIcon)
        infoIcon.anchor(top: infoView.topAnchor, leading: infoView.leadingAnchor, bottom: nil, trailling: nil, padding: .init(top: 24, left: 24, bottom: 0, right: 0), size: .init(width: 50, height: 50))

        infoView.addSubview(infoTitle)
        infoTitle.anchor(top: infoView.topAnchor, leading: infoView.leadingAnchor, bottom: nil, trailling: infoView.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))

        infoView.addSubview(infoText)
        infoText.anchor(top: infoTitle.bottomAnchor, leading: infoView.leadingAnchor, bottom: nil, trailling: infoView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }
}
