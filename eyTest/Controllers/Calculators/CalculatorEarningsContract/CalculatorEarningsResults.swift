//
//  CalculatorEarningsResults.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 27/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class CalculatorEarningsResults: BaseViewController {

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
        var shareData = ""

        shareData = titleLabel.text! + "\n"
        shareData = shareData + parameterTitle.text! + " " + currencyLabel.text! + "\n"
        shareData = shareData + calculationType.text! + " " + userInputValue.text! + "\n"

        for index in 0..<resultsTitles.count {
            let fv = calculationResults[index]


            let formatter: NumberFormatter = NumberFormatter()
            formatter.groupingSeparator = "."
            formatter.numberStyle = NumberFormatter.Style.decimal
            let formattedStr: NSString = formatter.string(from: NSNumber(value: fv))! as NSString

            shareData = shareData + resultsTitles[index]
            shareData = shareData + ": "
            shareData = shareData + (formattedStr as String)


            if index == resultsTitles.count - 1 {
                shareData = shareData + "%"
            } else {
                shareData = shareData + "\n"
            }
        }



        shareData.share()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = local as Locale
        numberFormatter.maximumFractionDigits = 2

        setupView()



        setupTableView()

        setLabels()

        userInputValue.text = numberFormatter.string(from: NSNumber(floatLiteral: Double(calculationParameters.userInput)!))!


        self.removeSpinner()
    }

    func setLabels() {
        if defaultLanguage == "sr" {

            parameterTitle.text = "За унете параметре:"

            if calculationParameters.currency == "eur" {
                currencyLabel.text = "ЕУР"
            } else {
                currencyLabel.text = "РСД"
            }

            if calculationParameters.titleType == "earnings" {
                titleLabel.text = "Калкулатор пореза на зараде"
            } else {
                titleLabel.text = "Калкулатор уговора о делу"
            }

            switch calculationParameters.calculationType {
            case "b2uN":
                calculationType.text = "Бруто 2 у Нетo"
                serbiaB2uN(bruto2: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            case "bUn":
                calculationType.text = "Бруто у Нето"
                ugovoroDeluBuN(netAmount: Double(calculationParameters.userInput)!, insurance: calculationParameters.insurance, standardCosts: Double(calculationParameters.standardCosts)! / 100, personalIncomeTax: Double(calculationParameters.personalIncome_tax)! / 100, pensionFund: Double(calculationParameters.contributionToPensionFund)! / 100, healthFund: Double(calculationParameters.contributionToHealthFund)! / 100)
            case "b1uN":
                calculationType.text = "Бруто 1 у Нетo"
                serbiaB1uN(bruto1: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            case "nUb":
                calculationType.text = "Нето у Бруто"
                ugovoroDeluNuB(netAmount: Double(calculationParameters.userInput)!, insurance: calculationParameters.insurance, standardCosts: Double(calculationParameters.standardCosts)! / 100, personalIncomeTax: Double(calculationParameters.personalIncome_tax)! / 100, pensionFund: Double(calculationParameters.contributionToPensionFund)! / 100, healthFund: Double(calculationParameters.contributionToHealthFund)! / 100)
            case "nUb1":
                calculationType.text = "Нето у Бруто 1"
                serbiaNuB1B2(neto: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            case "nUb2":
                calculationType.text = "Нето у Бруто 2"
                serbiaNuB1B2(neto: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            default:
                return
            }

        } else {

            parameterTitle.text = "For entered parameters:"

            if calculationParameters.currency == "eur" {
                currencyLabel.text = "EUR"
            } else {
                currencyLabel.text = "RSD"
            }

            if calculationParameters.titleType == "earnings" {
                titleLabel.text = "Wage tax calculator"
            } else {
                titleLabel.text = "Calculator Service Contract"
            }

            switch calculationParameters.calculationType {
            case "b2uN":
                calculationType.text = "Gross 2 to Net"
                serbiaB2uN(bruto2: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            case "bUn":
                calculationType.text = "Gross to Net"
                ugovoroDeluBuN(netAmount: Double(calculationParameters.userInput)!, insurance: calculationParameters.insurance, standardCosts: Double(calculationParameters.standardCosts)! / 100, personalIncomeTax: Double(calculationParameters.personalIncome_tax)! / 100, pensionFund: Double(calculationParameters.contributionToPensionFund)! / 100, healthFund: Double(calculationParameters.contributionToHealthFund)! / 100)
            case "b1uN":
                calculationType.text = "Gross 1 to Net"
                serbiaB1uN(bruto1: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            case "nUb":
                calculationType.text = "Net to Gross"
                ugovoroDeluNuB(netAmount: Double(calculationParameters.userInput)!, insurance: calculationParameters.insurance, standardCosts: Double(calculationParameters.standardCosts)! / 100, personalIncomeTax: Double(calculationParameters.personalIncome_tax)! / 100, pensionFund: Double(calculationParameters.contributionToPensionFund)! / 100, healthFund: Double(calculationParameters.contributionToHealthFund)! / 100)
            case "nUb1":
                calculationType.text = "Net to Gross 1"
                serbiaNuB1B2(neto: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            case "nUb2":
                calculationType.text = "Net to Gross 2"
                serbiaNuB1B2(neto: Double(calculationParameters.userInput)!, maxBase: Double(calculationParameters.maxBaseSocialContributions)!, nonTaxable: Double(calculationParameters.nonTaxableAmount)!, salaryTax: Double(calculationParameters.salaryTax)! / 100, socialEmployee: Double(calculationParameters.socialContributionsEmployee)! / 100, socialEmployer: Double(calculationParameters.socialContributionsEmployer)! / 100)
            default:
                return
            }

        }
    }

    fileprivate func setupView() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(shareButton)
        shareButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 12))

        view.addSubview(parameterContainerView)
        parameterContainerView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 140))

        setupParameterContainer()

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

    fileprivate func setupParameterContainer() {


        parameterContainerView.addSubview(parameterTitle)
        parameterTitle.anchor(top: parameterContainerView.topAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        parameterContainerView.addSubview(currencyLabel)
        currencyLabel.anchor(top: parameterTitle.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        parameterContainerView.addSubview(calculationType)
        calculationType.anchor(top: currencyLabel.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))

        parameterContainerView.addSubview(userInputValue)
        userInputValue.anchor(top: calculationType.bottomAnchor, leading: parameterContainerView.leadingAnchor, bottom: nil, trailling: parameterContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
    }

    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ResultsCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .clear
//        tableView.isUserInteractionEnabled = false
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        self.view.addSubview(tableView)

        tableView.anchor(top: parameterContainerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }

}

extension CalculatorEarningsResults: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ResultsCell

        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(hexString: "EFF0F1")
        } else {
            cell.backgroundColor = UIColor(hexString: "DEDFE0")
        }


        if indexPath.item == resultsTitles.count - 1 {
            cell.resultValue.text = numberFormatter.string(from: NSNumber(floatLiteral: calculationResults[indexPath.item]))! + "%"
        } else {
            cell.resultValue.text = numberFormatter.string(from: NSNumber(floatLiteral: calculationResults[indexPath.item]))!
        }

        cell.resultType.text = resultsTitles[indexPath.item]

        return cell
    }


}

extension CalculatorEarningsResults {
    func ugovoroDeluBuN (netAmount: Double, insurance: String, standardCosts: Double, personalIncomeTax: Double, pensionFund: Double, healthFund: Double) {

        let e10: Double = netAmount
        var e11: Double = 0
        var e12: Double = 0
        var e13: Double = 0
        var e15: Double = 0

        var e16: Double = 0
        var e17: Double = 0
        var e18: Double = 0

        var e20: Double = 0
        var e21: Double = 0

        let i10: Double = standardCosts
        let i11: Double = personalIncomeTax
        let i12: Double = pensionFund
        let i13: Double = healthFund

        let h16 = insurance

        for _ in 1...100 {

            e11 = e10 * i10

            e12 = e10 - e11

            e15 = e12 * i11

            e13 = e10 - e15 - e16

            e16 = e17 + e18

            e17 = e12 * i12

            if h16 == "ne" {
                e18 = e12 * i13
            } else {
                e18 = 0
            }

            e20 = e10

            e21 = (e15 + e16) / e13

        }

        // e21 = e21 * 100

        if defaultLanguage == "sr" {
            resultsTitles = ["Нето накнада", "Порез", "Доприноси за социјално осигурање", "Укупни трошкови послодавца", "Фискално оптерећење"]
        } else {
            resultsTitles = ["Net amount", "Tax", "Social security contributions", "Total costs for an employer", "Tax obligations vs. net amount (tax burden)"]

        }

        calculationResults = [e13, e15, e16, e20, e21]

    }

    func ugovoroDeluNuB (netAmount: Double, insurance: String, standardCosts: Double, personalIncomeTax: Double, pensionFund: Double, healthFund: Double) {

        let e10: Double = netAmount
        var e11: Double = 0
        var e12: Double = 0
        var e13: Double = 0
        var e14: Double = 0

        var e16: Double = 0
        var e17: Double = 0
        var e18: Double = 0
        var e19: Double = 0

        var e21: Double = 0
        var e22: Double = 0

        let i10: Double = standardCosts
        let i11: Double = personalIncomeTax
        let i12: Double = pensionFund
        let i13: Double = healthFund

        let h18 = insurance

        if h18 == "ne" {
            e11 = (1 / (1 - (1 - i10) * (i12 + i11 + i13)))
        } else {
            e11 = (1 / (1 - (1 - i10) * (i11 + i12)))
        }

        e12 = e10 * e11

        e13 = e12 * i10

        e14 = e12 - e13

        e16 = e14 * i11



        e18 = e14 * i12

        if h18 == "ne" {
            e19 = e14 * i13
        } else {
            e19 = 0
        }

        e17 = e18 + e19

        e21 = e12

        e22 = (e16 + e17) / e10

        // e22 = e22 * 100

        if defaultLanguage == "sr" {
            resultsTitles = ["Бруто приход ", "Порез на приходе од \n уговора о делу", "Доприноси за социјално осигурање", "Укупни трошкови послодавца", "Фискално оптерећење"]
        } else {
            resultsTitles = ["Gross revenue ", "Personal income tax 20%", "Social security contributions", "Total costs for an employer", "Tax obligations vs. net amount (tax burden)"]

        }
        calculationResults = [e12, e16, e17, e21, e22 * 100]


    }

    func serbiaNuB1B2 (neto: Double, maxBase: Double, nonTaxable: Double, salaryTax: Double, socialEmployee: Double, socialEmployer: Double) {

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
        var e25: Double = 0

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
        var f23: Double = 0

        for _ in 1...100 {

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

//            if e14 > e19 {
//                e21 = e14 * d21
//            } else {
//                e21 = e12 * d21
//            }

            if e14 > e12 {
                e21 = e12 * d21
            } else {
                e21 = e14 * d21
            }

            e23 = e14 + e21

            e25 = (e17 + e19 + e21) / e10

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

            f23 = f14 + f21
        }

        //e25 = e25 * 100

        if defaultLanguage == "sr" {
            resultsTitles = ["Бруто 1 зарада", "Порез на зараде", "Доприноси на терет радника", "Доприноси на терет послодавца", "УКУПНИ ТРОШКОВИ (БРУТО 2)", "Проценат фискалног оптерећења"]
        } else {
            resultsTitles = ["Gross 1 salary", "Salary Tax", "Social Contibutions on behalf of the Employee", "Social Contibutions on behalf of the Employer", "TOTAL EXPENSES (GROSS 2)", "Percentage Of The Fiscal Burden"]

        }
        calculationResults = [e14, e17, e19, e21, e23, e25 * 100]

    }

    func serbiaB1uN (bruto1: Double, maxBase: Double, nonTaxable: Double, salaryTax: Double, socialEmployee: Double, socialEmployer: Double) {

        let e10: Double = bruto1
        let e11: Double = maxBase
        var e12: Double = 0
        let e13: Double = nonTaxable
        var e14: Double = 0
        var e16: Double = 0
        var e18: Double = 0
        var e20: Double = 0
        var e22: Double = 0
        var e24: Double = 0

        let d16 = salaryTax
        let d18 = socialEmployee
        let d20 = socialEmployer

        var f10: Double = 0
        var f11: Double = 0
        var f12: Double = 0
        var f13: Double = 0
        var f14: Double = 0
        var f16: Double = 0
        var f18: Double = 0
        var f20: Double = 0
        var f22: Double = 0

        for _ in 1...100 {

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

            e22 = e10 + e20

            e24 = (e16 + e18 + e20) / e14

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

            f22 = f10 + f20

            // e24 = e24 * 100

            if defaultLanguage == "sr" {
                resultsTitles = ["Нето зарада пре годишњег \n пореза", "Порез на зараде", "Доприноси на терет радника", "Доприноси на терет послодавца", "УКУПНИ ТРОШКОВИ (БРУТО 2)", "Проценат фискалног оптерећења"]
            } else {
                resultsTitles = ["Net salary before annual tax", "Salary Tax", "Social Contibutions on behalf of the Employee", "Social Contibutions on behalf of the Employer", "TOTAL EXPENSES (GROSS 2)", "Percentage Of The Fiscal Burden"]
            }
            calculationResults = [e14, e16, e18, e20, e22, e24 * 100]

        }
    }

    func serbiaB2uN (bruto2: Double, maxBase: Double, nonTaxable: Double, salaryTax: Double, socialEmployee: Double, socialEmployer: Double) {
        let e10: Double = bruto2
        var e11: Double = 0
        let e12: Double = maxBase
        var e13: Double = 0
        let e14: Double = nonTaxable
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
        var _: Double = 0


        for _ in 1...100 {

            let celijaE11 = e15 + e17 + e19
            let celijaE10 = e11 + e21


            if celijaE10 == e10 && celijaE11 == e11 {
                break
            } else {
                e11 = e10 - e21

                if e11 > e12 {
                    e13 = e12
                } else {
                    e13 = e11
                }

                e15 = e11 - (e11 - e14) * 0.1 - (e13 * 0.199)

                e17 = (e11 - e14) * 0.1

                if e11 > e13 {
                    e19 = e13 * 0.199
                } else {
                    e19 = e11 * 0.199
                }

                if e11 > e13 {
                    e21 = e13 * 0.179
                } else {
                    e21 = e11 * 0.179
                }

                e23 = ((e17 + e19 + e21) / e15) * 100
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
        }

        //e23 = e23

        if defaultLanguage == "sr" {
            resultsTitles = ["Бруто 1 зарада", "Нето зарада пре годишњег \n пореза", "Порез на зараде", "Доприноси на терет радника", "Доприноси на терет послодавца", "Проценат фискалног оптерећења"]
        } else {
            resultsTitles = ["Gross 1 salary", "Net salary before annual tax", "Salary Tax", "Social Contibutions on behalf of the Employee", "Social Contibutions on behalf of the Employer", "Percentage Of The Fiscal Burden"]
        }
        calculationResults = [e11, e15, e17, e19, e21, e23]


    }

}
