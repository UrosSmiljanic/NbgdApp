//
//  CalculatorEarningsScreen.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 26/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit


class CalculatorEarningsScreen: BaseViewController {

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

    let grossInNetContainter: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        return view
    }()

    let netInGrossContainter: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(hexString: "dfdfdf").cgColor
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
        let screen = CalculatorEarningsInputScreen()

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

    func setLabels() {
        if defaultLanguage == "sr" {
            nextButton.setTitle("Даље", for: .normal)


            if choosenByUser.titleType == "earnings" {
                titleLabel.text = "Калкулатор пореза на зараде"
                currencyTitle.text = "Изаберите валуту"
                secondContainerTitle.text = "Изаберите опцију унос Бруто 1 или Бруто 2 ради прерачуна у Нето"
                thirdContainerTitle.text = "Изаберите опцију унос Нето ради прерачуна у Бруто 1 или Бруто 2"
                rsdButton.setTitle("РСД", for: .normal)
                eurButton.setTitle("ЕУР", for: .normal)
                grossTwoInNetoButton.setTitle("Б2->Н", for: .normal)
                grossInNetoButton.setTitle("Б1->Н", for: .normal)
                netToGrossOneButton.setTitle("Н->Б1", for: .normal)
                netToGrossTwoButton.setTitle("Н->Б2", for: .normal)

            } else {
                titleLabel.text = "Обрачун - Уговор о делу"
                currencyTitle.text = "Изаберите валуту"
                secondContainerTitle.text = "Изаберите опцију унос Нето, Бруто 1 или Бруто 2 месечног износа зараде"
                thirdContainerTitle.text = "Да ли је лице обавезно осигурано по другом основу?"
                rsdButton.setTitle("РСД", for: .normal)
                eurButton.setTitle("ЕУР", for: .normal)
                grossTwoInNetoButton.setTitle("Б->Н", for: .normal)
                grossInNetoButton.setTitle("Н->Б", for: .normal)
                netToGrossOneButton.setTitle("Да", for: .normal)
                netToGrossTwoButton.setTitle("Не", for: .normal)
            }

        } else {

            nextButton.setTitle("Next", for: .normal)


            if choosenByUser.titleType == "earnings" {
                titleLabel.text = "Wage tax calculator"
                currencyTitle.text = "Select currency"
                secondContainerTitle.text = "Select option Gross 1 or Gross 2 to Net"
                thirdContainerTitle.text = "Select option Net to Gross 1 or Gross 2"
                rsdButton.setTitle("RSD", for: .normal)
                eurButton.setTitle("EUR", for: .normal)
                grossTwoInNetoButton.setTitle("G2->N", for: .normal)
                grossInNetoButton.setTitle("B1->N", for: .normal)
                netToGrossOneButton.setTitle("N->G1", for: .normal)
                netToGrossTwoButton.setTitle("N->G2", for: .normal)
            } else {
                titleLabel.text = "Calculator Service Contract"
                currencyTitle.text = "Select currency"
                secondContainerTitle.text = "Select option Net to Gross 1 or Gross 2"
                thirdContainerTitle.text = "Is the individual already mandatory insured based on a different grounds"
                rsdButton.setTitle("RSD", for: .normal)
                eurButton.setTitle("EUR", for: .normal)
                grossTwoInNetoButton.setTitle("G->N", for: .normal)
                grossInNetoButton.setTitle("N->G", for: .normal)
                netToGrossOneButton.setTitle("Yes", for: .normal)
                netToGrossTwoButton.setTitle("No", for: .normal)
            }

        }
    }

    fileprivate func setupView() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: backButton.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 50), size: .init(width: 0, height: 70))

        view.addSubview(infoButton)
        infoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 12))

        view.addSubview(curencyContainer)
        curencyContainer.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 150))

        setupCurrencyContainer()

        view.addSubview(grossInNetContainter)
        grossInNetContainter.anchor(top: curencyContainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 150))

        setupGrossInNetContainer()

        view.addSubview(netInGrossContainter)
        netInGrossContainter.anchor(top: grossInNetContainter.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailling: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 150))

        setupNetInGrossContainer()

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

    let grossInNetoButton: UIButton = {
        let button = UIButton()
        button.setTitle("B1->N", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        button.isUserInteractionEnabled = false

        button.addTarget(self, action: #selector(handleSellectGrossInNetoButton), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectGrossInNetoButton() {
        grossInNetoButton.isUserInteractionEnabled = false
        grossTwoInNetoButton.isUserInteractionEnabled = true
        netToGrossTwoButton.isUserInteractionEnabled = true
        netToGrossOneButton.isUserInteractionEnabled = true

        grossInNetContainter.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        netInGrossContainter.layer.borderColor = UIColor(hexString: "dfdfdf").cgColor

        if choosenByUser.titleType == "earnings" {
            choosenByUser.calculationType = "b1uN"
            grossInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            grossTwoInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            netToGrossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        } else {
            choosenByUser.calculationType = "nUb"
            grossInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            grossTwoInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        }

    }

    let grossTwoInNetoButton: UIButton = {
        let button = UIButton()
        button.setTitle("B2->N", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        button.addTarget(self, action: #selector(handleSellectGrossTwoInNetoButton), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectGrossTwoInNetoButton() {
        grossTwoInNetoButton.isUserInteractionEnabled = false
        grossInNetoButton.isUserInteractionEnabled = true
        netToGrossTwoButton.isUserInteractionEnabled = true
        netToGrossOneButton.isUserInteractionEnabled = true

        grossInNetContainter.layer.borderColor = UIColor(hexString: "FEE433").cgColor
        netInGrossContainter.layer.borderColor = UIColor(hexString: "dfdfdf").cgColor

        if choosenByUser.titleType == "earnings" {
            choosenByUser.calculationType = "b2uN"
            grossTwoInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            grossInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            netToGrossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        } else {
            choosenByUser.calculationType = "bUn"
            grossTwoInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            grossInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        }


    }

    let secondContainerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()


    fileprivate func setupGrossInNetContainer() {


        let linesImage: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "lines")
            return view
        }()

        grossInNetContainter.addSubview(secondContainerTitle)
        secondContainerTitle.anchor(top: grossInNetContainter.topAnchor, leading: grossInNetContainter.leadingAnchor, bottom: nil, trailling: grossInNetContainter.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        grossInNetContainter.addSubview(grossInNetoButton)
        grossInNetoButton.anchor(top: nil, leading: grossInNetContainter.leadingAnchor, bottom: grossInNetContainter.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 22, bottom: 22, right: 0), size: .init(width: 75, height: 75))

        grossInNetContainter.addSubview(grossTwoInNetoButton)
        grossTwoInNetoButton.anchor(top: nil, leading: nil, bottom: grossInNetContainter.bottomAnchor, trailling: grossInNetContainter.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 22, right: 22), size: .init(width: 75, height: 75))

        grossInNetContainter.addSubview(linesImage)
        linesImage.anchor(top: nil, leading: grossInNetoButton.trailingAnchor, bottom: grossTwoInNetoButton.bottomAnchor, trailling: grossTwoInNetoButton.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 27, right: 12), size: .init(width: 0, height: 12))
    }

    let netToGrossOneButton: UIButton = {
        let button = UIButton()
        button.setTitle("N->B1", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        button.isUserInteractionEnabled = false

        button.addTarget(self, action: #selector(handleSellectNetToGross), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectNetToGross() {
        netToGrossOneButton.isUserInteractionEnabled = false
        netToGrossTwoButton.isUserInteractionEnabled = true
        grossInNetoButton.isUserInteractionEnabled = true
        grossTwoInNetoButton.isUserInteractionEnabled = true

        grossInNetContainter.layer.borderColor = UIColor(hexString: "dfdfdf").cgColor
        netInGrossContainter.layer.borderColor = UIColor(hexString: "FEE433").cgColor

        if choosenByUser.titleType == "earnings" {
            choosenByUser.calculationType = "nUb1"
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            netToGrossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            grossTwoInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            grossInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        } else {
            choosenByUser.insurance = "da"
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            netToGrossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        }


    }

    let netToGrossTwoButton: UIButton = {
        let button = UIButton()
        button.setTitle("N->B2", for: .normal)
        button.titleLabel?.font = UIFont(name: "EYInterstate-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)

        button.addTarget(self, action: #selector(handleSellectNetToGrossTwo), for: .touchUpInside)

        return button
    }()

    @objc func handleSellectNetToGrossTwo() {
        netToGrossTwoButton.isUserInteractionEnabled = false
        netToGrossOneButton.isUserInteractionEnabled = true
        grossInNetoButton.isUserInteractionEnabled = true
        grossTwoInNetoButton.isUserInteractionEnabled = true

        grossInNetContainter.layer.borderColor = UIColor(hexString: "dfdfdf").cgColor
        netInGrossContainter.layer.borderColor = UIColor(hexString: "FEE433").cgColor

        if choosenByUser.titleType == "earnings" {
            choosenByUser.calculationType = "nUb2"
            netToGrossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            grossTwoInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
            grossInNetoButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        } else {
            choosenByUser.insurance = "ne"
            netToGrossTwoButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        }

    }

    let thirdContainerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EYInterstate-LightBold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    fileprivate func setupNetInGrossContainer() {



        let linesImage: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "lines")
            return view
        }()

        netInGrossContainter.addSubview(thirdContainerTitle)
        thirdContainerTitle.anchor(top: netInGrossContainter.topAnchor, leading: netInGrossContainter.leadingAnchor, bottom: nil, trailling: netInGrossContainter.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        netInGrossContainter.addSubview(netToGrossOneButton)
        netToGrossOneButton.anchor(top: nil, leading: netInGrossContainter.leadingAnchor, bottom: netInGrossContainter.bottomAnchor, trailling: nil, padding: .init(top: 0, left: 22, bottom: 22, right: 0), size: .init(width: 75, height: 75))

        if choosenByUser.titleType == "earnings" {
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCircle"), for: .normal)
        } else {
            netToGrossOneButton.setBackgroundImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
        }

        netInGrossContainter.addSubview(netToGrossTwoButton)
        netToGrossTwoButton.anchor(top: nil, leading: nil, bottom: netInGrossContainter.bottomAnchor, trailling: netInGrossContainter.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 22, right: 22), size: .init(width: 75, height: 75))

        netInGrossContainter.addSubview(linesImage)
        linesImage.anchor(top: nil, leading: netToGrossOneButton.trailingAnchor, bottom: netToGrossTwoButton.bottomAnchor, trailling: netToGrossTwoButton.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 27, right: 12), size: .init(width: 0, height: 12))
    }
}
