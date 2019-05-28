//
//  YearlyCalculatorResultsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 27/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class YearlyCalculatorResultsScreen: BaseViewController {

    var numberFormatter = NumberFormatter()
    let local = NSLocale(localeIdentifier: "de_DE")

    var resultsTitles = [String]()
    var calculationResults = [Double]()

    var calculationParameters = calculatorData()
    var tableView: UITableView!
    let cellId = "tableCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.addTarget(self, action: #selector(handleShareAction), for: .touchUpInside)
        return button
    }()

    let parameterContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEE433")
        return view
    }()

    @objc func handleShareAction() {
        var shareData = titleLabel.text! + "\n"
        shareData = shareData + parameterTitle.text! + " " + currencyLabel.text! + "\n" + calculationType.text! + " " + userInputValue.text! + "\n" + numberOfFamilyMembersLabel.text! + " " + numberOfFamilyMembersValue.text! + "\n"
        shareData = shareData + resultLabel.text! + ": " + resultValue.text!

        shareData.share()
    }

    let resultContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "DEDFE0")
        return view
    }()

    let infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "EFF0F1")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = local as Locale
        numberFormatter.maximumFractionDigits = 2

        setupView()


        setLabels()

		userInputValue.text = numberFormatter.string(from: NSNumber(floatLiteral: Double(calculationParameters.userInput)))!
        numberOfFamilyMembersValue.text = calculationParameters.numberOfFamilyMembers


        self.removeSpinner()
    }


    fileprivate func setupView() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(shareButton)
        shareButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 12))

        view.addSubview(parameterContainerView)
        parameterContainerView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 204))

        setupParameterContainer()

        view.addSubview(resultContainerView)
        resultContainerView.anchor(top: parameterContainerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 80))

        setResultContainerView()

        view.addSubview(infoContainerView)
        infoContainerView.anchor(top: resultContainerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor)

        setInfoContainerView()

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

    let userInputValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.textAlignment = .center

        return label
    }()

    let numberOfFamilyMembersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.textAlignment = .center

        return label
    }()

    let numberOfFamilyMembersValue: UILabel = {
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

        parameterContainerView.addSubview(userInputValue)
        userInputValue.anchor(top: calculationType.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        parameterContainerView.addSubview(numberOfFamilyMembersLabel)
        numberOfFamilyMembersLabel.anchor(top: userInputValue.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        parameterContainerView.addSubview(numberOfFamilyMembersValue)
        numberOfFamilyMembersValue.anchor(top: numberOfFamilyMembersLabel.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
    }

    let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    let resultValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Bold", size: 17)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()

    fileprivate func setResultContainerView() {



        resultContainerView.addSubview(resultLabel)
        resultLabel.anchor(top: resultContainerView.topAnchor, leading: resultContainerView.leadingAnchor, bottom: resultContainerView.bottomAnchor, trailling: nil, padding: .init(top: 12, left: 12, bottom: 12, right: 0), size: .init(width: view.frame.width * 0.7, height: 0))

        resultContainerView.addSubview(resultValue)
        resultValue.anchor(top: resultContainerView.topAnchor, leading: resultLabel.trailingAnchor, bottom: resultContainerView.bottomAnchor, trailling: resultContainerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))

    }

    let firstInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    let secondInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    fileprivate func setInfoContainerView() {
        infoContainerView.addSubview(firstInfo)
        firstInfo.anchor(top: infoContainerView.topAnchor, leading: infoContainerView.leadingAnchor, bottom: nil, trailling: infoContainerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        infoContainerView.addSubview(secondInfo)
        secondInfo.anchor(top: firstInfo.bottomAnchor, leading: infoContainerView.leadingAnchor, bottom: nil, trailling: infoContainerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }

    func setLabels() {
        if defaultLanguage == "sr" {

            firstInfo.text = "* Рок за подношење пореске пријаве је 15. мај"
            secondInfo.text = "* Месечна зарада коју унесете за обрачун годишњег пореза ће се рачунати за период од 12 месеци."
            resultLabel.text = "Износ годишњег пореза на доходак грађана (РСД)"
            parameterTitle.text = "ЗА УНЕТЕ ПАРАМЕТРЕ:"
            titleLabel.text = "Калкулатор - Годишњи порез на доходак грађана"
            numberOfFamilyMembersLabel.text = "Број издржаваних чланова породице"

            if calculationParameters.currency == "eur" {
                currencyLabel.text = "ЕУР"
            } else {
                currencyLabel.text = "РСД"
            }
        } else {

            firstInfo.text = "* The deadline for filing the tax return is May 15th"
            secondInfo.text = "* The monthly salary you enter for the annual tax calculation will be calculated for a period of 12 months"
            resultLabel.text = "Yearly individual Income tax (RSD)"
            parameterTitle.text = "FOR ENTERED PARAMETERS:"
            titleLabel.text = "Calculation - Annual income tax for citizens"
            numberOfFamilyMembersLabel.text = "Number of dependent family members"

            if calculationParameters.currency == "eur" {
                currencyLabel.text = "EUR"
            } else {
                currencyLabel.text = "RSD"
            }
        }

        switch calculationParameters.calculationType {
        case "godisnjiN":
            if defaultLanguage == "sr" {
                calculationType.text = "Нето месечна зарада"

            } else {
                calculationType.text = "Net monthly salary"

            }

            //            amountLbl.text = String(Int(CommonValues.userInputValue))
            //            numberOfFamilyMemmbersLbl.text = String(Int(CommonValues.userInputFamily))


			godisnjiN(neto: Double(calculationParameters.userInput), maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100, familyNum: Double(calculationParameters.numberOfFamilyMembers)!, averageSalary: Double(calculationParameters.averageAnnualIncome)!, yearlyTaxOne: Double(calculationParameters.taxRatesAnual_1)! / 100, yearlyTaxTwo: Double(calculationParameters.taxRatesAnual_2)! / 100)
        case "godisnjiBone":
            if defaultLanguage == "sr" {
                calculationType.text = "Бруто 1 месечна зарада"
            } else {
                calculationType.text = "Gross 1 monthly salary"
            }

            //            amountLbl.text = String(CommonValues.userInputValue)
            //            numberOfFamilyMemmbersLbl.text = String(CommonValues.userInputFamily)

			godisnjiBon(bruto: Double(calculationParameters.userInput), maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100, familyNum: Double(calculationParameters.numberOfFamilyMembers)!, averageSalary: Double(calculationParameters.averageAnnualIncome)!, yearlyTaxOne: Double(calculationParameters.taxRatesAnual_1)! / 100, yearlyTaxTwo: Double(calculationParameters.taxRatesAnual_2)! / 100)
        case "godisnjiBtwo":
            if defaultLanguage == "sr" {
                calculationType.text = "Бруто 2 месечна зарада"

            } else {
                calculationType.text = "Gross 2 monthly salary"

            }
            //            amountLbl.text = String(CommonValues.userInputValue)
            //            numberOfFamilyMemmbersLbl.text = String(CommonValues.userInputFamily)

			godisnjiBtwo(bruto: Double(calculationParameters.userInput), maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100, familyNum: Double(calculationParameters.numberOfFamilyMembers)!, averageSalary: Double(calculationParameters.averageAnnualIncome)!, yearlyTaxOne: Double(calculationParameters.taxRatesAnual_1)! / 100, yearlyTaxTwo: Double(calculationParameters.taxRatesAnual_2)! / 100)
        default:
            return
        }
    }

}

extension YearlyCalculatorResultsScreen {
    func godisnjiN (neto: Double, maxBase: Double, nonTaxable: Double, salaryTax: Double, socialEmployee: Double, socialEmployer: Double, familyNum: Double, averageSalary: Double, yearlyTaxOne: Double, yearlyTaxTwo: Double) {

        let e10: Double = neto
        let e11: Double = maxBase
        var e12: Double = 0
        let e13: Double = nonTaxable
        var e14: Double = 0
        var e15: Double = 0
        var e17: Double = 0
        var e19: Double = 0
        var e21: Double = 0
        var e23: Double = 0

        let d17 = salaryTax
        let d19 = socialEmployee
        let d21 = socialEmployer

        var f10: Double = 0
        var f11: Double = 0
        var f12: Double = 0
        var f13: Double = 0
        var f14: Double = 0
        var f15: Double = 0
        var f17: Double = 0
        var f19: Double = 0
        var f21: Double = 0

        var j10: Double = 0
        var j11: Double = 0
        var j12: Double = 0
        var j13: Double = 0
        var j14: Double = familyNum
        var j15: Double = 0
        var j16: Double = 0
        var j17: Double = 0
        var j18: Double = 0
        var j19: Double = 0
        var j20: Double = 0

        let l9: Double = averageSalary
        var l12: Double = 0
        var l15: Double = 0
        let l18: Double = yearlyTaxOne
        let l19: Double = yearlyTaxTwo


        for i in 1...100 {

            if e14 > e11 {
                e12 = e11
            } else {
                e12 = e14
            }

            if e14 > e11 {
                e14 = (e10 - (e13 * d17) + (e11 * d19)) / (1 - d17)
            } else {
                e14 = (e10 - e13 * d17) / (1 - d19 - d17)
            }

            e15 = e14 - e17 - e19

            e17 = (e14 - e13) * d17

            if e14 > e12 {
                e19 = e12 * d19
            } else {
                e19 = e14 * d19
            }

            if e14 > e19 {
                e21 = e14 * d21
            } else {
                e21 = e12 * d21
            }

            f10 = e10 * 12

            f11 = e11 * 12

            if f14 > f11 {
                f12 = f11
            } else {
                f12 = f14
            }

            f13 = e13 * 12

            if f14 > f11 {
                f14 = (f10 - (f13 * d17) + (f11 * d19)) / (1 - d17)
            } else {
                f14 = (f10 - f13 * d17) / (1 - d19 - d17)
            }

            f15 = f14 - f17 - f19

            f17 = (f14 - f13) * d17

            if f14 > f12 {
                f19 = f12 * d19
            } else {
                f19 = f14 * d19
            }

            if f14 > f12 {
                f21 = f12 * d21
            } else {
                f21 = f14 * d21
            }

            l12 = l9 * 3

            l15 = l9 * 6


            j10 = f15 - f13

            j11 = l12

            if j10 < j11 {
                j12 = 0
            } else {
                j12 = j10 - j11
            }

            j13 = j12 * 0.5

            if j14 > 0 {
                j15 = j16 + j17
            } else {
                j15 = j16
            }

            j16 = l9 * 0.4

            j17 = l9 * 0.15 * j14

            if j13 < j15 {
                j18 = j13
            } else {
                j18 = j15
            }

            j19 = j12 - j18

            if j10 < j11 {
                j20 = 0
            } else {
                if j19 <= l15 {
                    j20 = j19 * l18
                } else {
                    j20 = l15 * l18 + (j19 - l15) * l19
                }
            }

        }


print(j20)


        resultValue.text = numberFormatter.string(from: NSNumber(floatLiteral: j20))!

    }

    func godisnjiBon (bruto: Double, maxBase: Double, nonTaxable: Double, salaryTax: Double, socialEmployee: Double, socialEmployer: Double, familyNum: Double, averageSalary: Double, yearlyTaxOne: Double, yearlyTaxTwo: Double) {

        let e10: Double = bruto
        let e11: Double = maxBase
        var e12: Double = 0
        let e13: Double = nonTaxable
        var e14: Double = 0
        var e16: Double = 0
        var e18: Double = 0
        var e20: Double = 0

        let d16: Double = salaryTax
        let d18: Double = socialEmployee
        let d20: Double = socialEmployer

        var f10: Double = 0
        var f11: Double = 0
        var f12: Double = 0
        var f13: Double = 0
        var f14: Double = 0
        var f16: Double = 0
        var f18: Double = 0
        var f20: Double = 0

        var j10: Double = 0
        var j11: Double = 0
        var j12: Double = 0
        var j13: Double = 0
        let j14: Double = familyNum
        var j15: Double = 0
        var j16: Double = 0
        var j17: Double = 0
        var j18: Double = 0
        var j19: Double = 0
        var j20: Double = 0

        let l9: Double = averageSalary
        var l12: Double = 0
        var l15: Double = 0
        let l18: Double = yearlyTaxOne
        let l19: Double = yearlyTaxTwo

        for i in 1...100 {

            if e10 > e11 {
                e12 = e11
            } else {
                e12 = e10
            }

            e14 = e10 - (e10 - e13) * d16 - (e12 * d18)

            e16 = (e10 - e13) * d16

            if e10 > e12 {
                e18 = e12 * d18
            } else {
                e18 = e10 * d18
            }

            if e10 > e12 {
                e20 = e12 * d20
            } else {
                e20 = e10 * d20
            }


            f10 = e10 * 12

            f11 = e11 * 12

            if f10 > f11 {
                f12 = f11
            } else {
                f12 = f10
            }

            f13 = e13 * 12

            f14 = f10 - (f10 - f13) * d16 - (f12 * d18)

            f16 = (f10 - f13) * d16

            if f10 > f12 {
                f18 = f12 * d18
            } else {
                f18 = f10 * d18
            }

            if f10 > f12 {
                f20 = f12 * d20
            } else {
                f20 = f10 * d20
            }

            l12 = l9 * 3

            l15 = l9 * 6

            j10 = f14 - f13

            j11 = l12

            if j10 < j11 {
                j12 = 0
            } else {
                j12 = j10 - j11
            }

            j13 = j12 * 0.5

            if j14 > 0 {
                j15 = j16 + j17
            } else {
                j15 = j16
            }

            j16 = l9 * 0.4

            j17 = l9 * 0.15 * j14

            if j13 < j15 {
                j18 = j13
            } else {
                j18 = j15
            }

            j19 = j12 - j18

            if j10 < j11 {
                j20 = 0
            }else {
                if j19 <= l15 {
                    j20 = j19 * l18
                } else {
                    j20 = l15 * l18 + (j19 - l15) * l19
                }
            }
        }



        //        var fv = j20.truncate(places: 0)
        //
        //        if CommonValues.eurSelected {
        //            let res = j20 / CommonValues.eurValue
        //            fv = res.truncate(places: 0)
        //        }
        //        let formatter: NumberFormatter = NumberFormatter()
        //        formatter.groupingSeparator = "."
        //        formatter.numberStyle = NumberFormatter.Style.decimal
        //        let formattedStr: NSString = formatter.string(from: NSNumber(value: fv))! as NSString
        //        calcResultLbl.text = formattedStr as String

        resultValue.text = numberFormatter.string(from: NSNumber(floatLiteral: j20))!

    }

    func godisnjiBtwo (bruto: Double, maxBase: Double, nonTaxable: Double, salaryTax: Double, socialEmployee: Double, socialEmployer: Double, familyNum: Double, averageSalary: Double, yearlyTaxOne: Double, yearlyTaxTwo: Double) {

        let e10: Double = bruto
        var e11: Double = 0
        let e12: Double = maxBase
        var e13: Double = 0
        let e14: Double = nonTaxable
        var e15: Double = 0
        var e17: Double = 0
        var e19: Double = 0
        var e21: Double = 0

        var d17: Double = salaryTax
        var d19: Double = socialEmployee
        var d21: Double = socialEmployer

        var f10: Double = 0
        var f11: Double = 0
        var f12: Double = 0
        var f13: Double = 0
        var f14: Double = 0
        var f15: Double = 0
        var f17: Double = 0
        var f19: Double = 0
        var f21: Double = 0

        var j10: Double = 0
        var j11: Double = 0
        var j12: Double = 0
        var j13: Double = 0
        var j14: Double = familyNum
        var j15: Double = 0
        var j16: Double = 0
        var j17: Double = 0
        var j18: Double = 0
        var j19: Double = 0
        var j20: Double = 0

        var l9: Double = averageSalary
        var l12: Double = 0
        var l15: Double = 0
        var l18: Double = yearlyTaxOne
        var l19: Double = yearlyTaxTwo

        for i in 1...100 {

            e11 = e10 - e21

            if e11 > e12 {
                e13 = e12
            } else {
                e13 = e11
            }

            e15 = e11 - (e11 - e14) * d17 - (e13 * d19)

            e17 = (e11 - e14) * d17

            if e11 > e13 {
                e19 = e13 * d19
            } else {
                e19 = e11 * d19
            }

            if e11 > e13 {
                e21 = e13 * d21
            } else {
                e21 = e11 * d21
            }

            f10 = e10 * 12

            f11 = f10 - f21

            f12 = e12 * 12

            if f11 > f12 {
                f13 = f12
            } else {
                f13 = f11
            }

            f14 = e14 * 12

            f15 = f11 - (f11 - f14) * d17 - (f13 * d19)

            f17 = (f11 - f14) * d17

            if f11 > f13 {
                f19 = f13 * d19
            } else {
                f19 = f11 * d19
            }

            if f11 > f13 {
                f21 = f13 * d21
            } else {
                f21 = f11 * d21
            }

            l12 = l9 * 3

            l15 = l9 * 6

            j10 = f15 - f14

            j11 = l12

            if j10 < j11 {
                j12 = 0
            } else {
                j12 = j10 - j11
            }

            j13 = j12 * 0.5

            if j14 > 0 {
                j15 = j16 + j17
            } else {
                j15 = j16
            }

            j16 = l9 * 0.4

            j17 = l9 * 0.15 * j14

            if j13 < j15 {
                j18 = j13
            } else {
                j18 = j15
            }

            j19 = j12 - j18

            if j10 < j11 {
                j20 = 0
            } else {
                if j19 <= l15 {
                    j20 = j19 * l18
                } else {
                    j20 = l15 * l18 + (j19 - l15) * l19
                }
            }

        }
        //
        //        var fv = j20.truncate(places: 0)
        //
        //        if CommonValues.eurSelected {
        //            let res = j20 / CommonValues.eurValue
        //            fv = res.truncate(places: 0)
        //        }
        //
        //        let formatter: NumberFormatter = NumberFormatter()
        //        formatter.groupingSeparator = "."
        //        formatter.numberStyle = NumberFormatter.Style.decimal
        //        let formattedStr: NSString = formatter.string(from: NSNumber(value: fv))! as NSString
        //        calcResultLbl.text = formattedStr as String

        resultValue.text = numberFormatter.string(from: NSNumber(floatLiteral: j20))!

    }
}
