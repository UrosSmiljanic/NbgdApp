//
//  YearlyCalculatorScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 27/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

class YearlyCalculatorScreen: BaseViewController {
    
    var choosenByUser = calculatorData()
    let url = "http://ey.nbgcreator.com/api/config/?keys[]=mob_calculator_average_annual_income&keys[]=mob_calculator_contribution_to_health_fund&keys[]=mob_calculator_contribution_to_pension_fund&keys[]=mob_calculator_max_base_social_contributions&keys[]=mob_calculator_non_taxable_amount&keys[]=mob_calculator_personal_income_tax&keys[]=mob_calculator_salary_tax&keys[]=mob_calculator_social_contributions_employee&keys[]=mob_calculator_social_contributions_employer&keys[]=mob_calculator_standard_costs&keys[]=mob_calculator_tax_rates_anual_1&keys[]=mob_calculator_tax_rates_anual_2"

    var titleText: String?

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

    let curencyContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(hexString: "dfdfdf").cgColor
        return view
    }()

    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        return view
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

        button.addTarget(self, action: #selector(handeGoToInputScreen), for: .touchUpInside)

        return button
    }()

    @objc func handeGoToInputScreen() {
        let screen = YearlyCalculatorInputScreen()

        screen.calculationParameters = choosenByUser

        let vc = UINavigationController(rootViewController: screen)
        present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeSpinner()

        setLabels()

        setupView()

        fetchGenericData(urlString: url) { (data: CalculatorData?, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.errorMessage.isHidden = false
                    self.removeSpinner()
                }
                return
            }
            DispatchQueue.main.async {
                self.choosenByUser.averageAnnualIncome = data!.entity.mobCalculatorAverageAnnualIncome
                self.choosenByUser.contributionToHealthFund = data!.entity.mobCalculatorContributionToHealthFund
                self.choosenByUser.contributionToPensionFund = data!.entity.mobCalculatorContributionToPensionFund
                self.choosenByUser.maxBaseSocialContributions = data!.entity.mobCalculatorMaxBaseSocialContributions
                self.choosenByUser.nonTaxableAmount = data!.entity.mobCalculatorNonTaxableAmount
                self.choosenByUser.personalIncome_tax = data!.entity.mobCalculatorPersonalIncomeTax
                self.choosenByUser.salaryTax = data!.entity.mobCalculatorSalaryTax
                self.choosenByUser.socialContributionsEmployee = data!.entity.mobCalculatorSocialContributionsEmployee
                self.choosenByUser.socialContributionsEmployer = data!.entity.mobCalculatorSocialContributionsEmployer
                self.choosenByUser.standardCosts = data!.entity.mobCalculatorStandardCosts
                self.choosenByUser.taxRatesAnual_1 =  data!.entity.mobCalculatorTaxRatesAnual1
                self.choosenByUser.taxRatesAnual_2 = data!.entity.mobCalculatorTaxRatesAnual2
            }
        }

//        fetchGenericData(urlString: url) { (data: CalculatorData) in
//            DispatchQueue.main.async {
//                self.choosenByUser.averageAnnualIncome = data.entity.mobCalculatorAverageAnnualIncome
//                self.choosenByUser.contributionToHealthFund = data.entity.mobCalculatorContributionToHealthFund
//                self.choosenByUser.contributionToPensionFund = data.entity.mobCalculatorContributionToPensionFund
//                self.choosenByUser.maxBaseSocialContributions = data.entity.mobCalculatorMaxBaseSocialContributions
//                self.choosenByUser.nonTaxableAmount = data.entity.mobCalculatorNonTaxableAmount
//                self.choosenByUser.personalIncome_tax = data.entity.mobCalculatorPersonalIncomeTax
//                self.choosenByUser.salaryTax = data.entity.mobCalculatorSalaryTax
//                self.choosenByUser.socialContributionsEmployee = data.entity.mobCalculatorSocialContributionsEmployee
//                self.choosenByUser.socialContributionsEmployer = data.entity.mobCalculatorSocialContributionsEmployer
//                self.choosenByUser.standardCosts = data.entity.mobCalculatorStandardCosts
//                self.choosenByUser.taxRatesAnual_1 =  data.entity.mobCalculatorTaxRatesAnual1
//                self.choosenByUser.taxRatesAnual_2 = data.entity.mobCalculatorTaxRatesAnual2
//            }
//        }
    }
    
    fileprivate func setupView() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(infoButton)
        infoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 12))

        view.addSubview(curencyContainer)
        curencyContainer.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 150))

        setupCurrencyContainer()

        view.addSubview(containerView)
        containerView.anchor(top: curencyContainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 150))

        setContainerView()

       
        view.addSubview(nextButton)
        nextButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 12, right: 12), size: .init(width: view.frame.width - 24, height: 50))
    }

    let rsdButton: UIButton = {
        let button = UIButton()
        button.setTitle("RSD", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        button.isUserInteractionEnabled = false

        button.addTarget(self, action: #selector(handleSellectRsd), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectRsd() {
        rsdButton.isUserInteractionEnabled = false
        eurButton.isUserInteractionEnabled = true
        rsdButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        eurButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        choosenByUser.currency = "rsd"
    }

    let eurButton: UIButton = {
        let button = UIButton()
        button.setTitle("EUR", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        button.addTarget(self, action: #selector(handleSellectEur), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectEur() {
        eurButton.isUserInteractionEnabled = false
        rsdButton.isUserInteractionEnabled = true
        eurButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        rsdButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        choosenByUser.currency = "eur"
    }

    let currencyTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.text = "Izaberite kurs"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    fileprivate func setupCurrencyContainer() {

        let linesImage: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "lines")
            return view
        }()

        curencyContainer.addSubview(currencyTitle)
        currencyTitle.anchor(top: curencyContainer.topAnchor, leading: curencyContainer.leadingAnchor, bottom: nil, trailling: curencyContainer.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        curencyContainer.addSubview(rsdButton)
        rsdButton.anchor(top: nil, leading: curencyContainer.leadingAnchor, bottom: curencyContainer.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 22, bottom: 22, right: 0), size: .init(width: 75, height: 75))

        curencyContainer.addSubview(eurButton)
        eurButton.anchor(top: nil, leading: nil, bottom: curencyContainer.bottomAnchor, trailling: curencyContainer.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 22, right: 22), size: .init(width: 75, height: 75))

        curencyContainer.addSubview(linesImage)
        linesImage.anchor(top: nil, leading: rsdButton.trailingAnchor, bottom: eurButton.bottomAnchor, trailling: eurButton.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 27, right: 12), size: .init(width: 0, height: 12))
    }

    let netButton: UIButton = {
        let button = UIButton()
        button.setTitle("B1->N", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        button.isUserInteractionEnabled = false

        button.addTarget(self, action: #selector(handleSellectNetButton), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectNetButton() {
        netButton.isUserInteractionEnabled = false
        grossOneButton.isUserInteractionEnabled = true
        grossTwoButton.isUserInteractionEnabled = true
        netButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        grossOneButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        grossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        containerView.layer.borderColor = UIColor(hexString: "FEE433").cgColor

        choosenByUser.calculationType = "godisnjiN"


    }

    let grossOneButton: UIButton = {
        let button = UIButton()
        button.setTitle("B2->N", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        button.addTarget(self, action: #selector(handleSellectGrossOneButton), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectGrossOneButton() {
        grossOneButton.isUserInteractionEnabled = false
        netButton.isUserInteractionEnabled = true
        grossTwoButton.isUserInteractionEnabled = true
        grossOneButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        netButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        grossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        containerView.layer.borderColor = UIColor(hexString: "FEE433").cgColor

        choosenByUser.calculationType = "godisnjiBone"

    }

    let grossTwoButton: UIButton = {
        let button = UIButton()
        button.setTitle("B2->N", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        button.addTarget(self, action: #selector(handleSellectGrossTwoButton), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectGrossTwoButton() {
        grossTwoButton.isUserInteractionEnabled = false
        grossOneButton.isUserInteractionEnabled = true
        netButton.isUserInteractionEnabled = true
        grossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        netButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        grossOneButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        choosenByUser.calculationType = "godisnjiBtwo"

    }

    let containerViewTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()


    fileprivate func setContainerView() {


        let leftShortLines: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "shortLInes")
            return view
        }()

        let rightShortLines: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "shortLInes")
            return view
        }()

        containerView.addSubview(containerViewTitle)
        containerViewTitle.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailling: containerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        containerView.addSubview(netButton)
        netButton.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 18, bottom: 22, right: 0), size: .init(width: 75, height: 75))

        containerView.addSubview(leftShortLines)
        leftShortLines.anchor(top: nil, leading: netButton.trailingAnchor, bottom: netButton.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 12, bottom: 23, right: 0), size: .init(width: 0, height: 12))

        containerView.addSubview(grossOneButton)
        grossOneButton.anchor(top: nil, leading: leftShortLines.trailingAnchor, bottom: containerView.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 12, bottom: 22, right: 0), size: .init(width: 75, height: 75))

        containerView.addSubview(rightShortLines)
        rightShortLines.anchor(top: nil, leading: grossOneButton.trailingAnchor, bottom: grossOneButton.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 12, bottom: 23, right: 0), size: .init(width: 0, height: 12))

        containerView.addSubview(grossTwoButton)
        grossTwoButton.anchor(top: nil, leading: rightShortLines.trailingAnchor, bottom: containerView.bottomAnchor, trailling: containerView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 22, right: 18), size: .init(width: 75, height: 75))
    }

    fileprivate func setLabels() {
        if defaultLanguage == "sr" {
            nextButton.setTitle("Даље", for: .normal)
            titleLabel.text = "Калкулатор - Годишњи порез на доходак грађана"
            currencyTitle.text = "Изаберите валуту"
            containerViewTitle.text = "Изаберите опцију унос Бруто 1 или Бруто 2 ради прерачуна у Нето"
            rsdButton.setTitle("РСД", for: .normal)
            eurButton.setTitle("ЕУР", for: .normal)
            netButton.setTitle("Н", for: .normal)
            grossOneButton.setTitle("Б1", for: .normal)
            grossTwoButton.setTitle("Б2", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
            titleLabel.text = "Calculation - Annual income tax for citizens"
            currencyTitle.text = "Select currency"
            containerViewTitle.text = "Select the option to enter Gross 1 or Gross 2 to convert to Net"
            rsdButton.setTitle("RSD", for: .normal)
            eurButton.setTitle("EUR", for: .normal)
            netButton.setTitle("N", for: .normal)
            grossOneButton.setTitle("B1", for: .normal)
            grossTwoButton.setTitle("B2", for: .normal)
        }
    }

}
