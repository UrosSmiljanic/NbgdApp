//
//  CalculatorsModel.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 27/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct CalculatorData: Codable {
    let status: Int
    let entity: EntityCalculator
    let message: JSONNull?
}

struct EntityCalculator: Codable {
    let mobCalculatorAverageAnnualIncome, mobCalculatorContributionToHealthFund, mobCalculatorContributionToPensionFund, mobCalculatorMaxBaseSocialContributions: String
    let mobCalculatorNonTaxableAmount, mobCalculatorPersonalIncomeTax, mobCalculatorSalaryTax, mobCalculatorSocialContributionsEmployee: String
    let mobCalculatorSocialContributionsEmployer, mobCalculatorStandardCosts, mobCalculatorTaxRatesAnual1, mobCalculatorTaxRatesAnual2: String

    enum CodingKeys: String, CodingKey {
        case mobCalculatorAverageAnnualIncome = "mob_calculator_average_annual_income"
        case mobCalculatorContributionToHealthFund = "mob_calculator_contribution_to_health_fund"
        case mobCalculatorContributionToPensionFund = "mob_calculator_contribution_to_pension_fund"
        case mobCalculatorMaxBaseSocialContributions = "mob_calculator_max_base_social_contributions"
        case mobCalculatorNonTaxableAmount = "mob_calculator_non_taxable_amount"
        case mobCalculatorPersonalIncomeTax = "mob_calculator_personal_income_tax"
        case mobCalculatorSalaryTax = "mob_calculator_salary_tax"
        case mobCalculatorSocialContributionsEmployee = "mob_calculator_social_contributions_employee"
        case mobCalculatorSocialContributionsEmployer = "mob_calculator_social_contributions_employer"
        case mobCalculatorStandardCosts = "mob_calculator_standard_costs"
        case mobCalculatorTaxRatesAnual1 = "mob_calculator_tax_rates_anual_1"
        case mobCalculatorTaxRatesAnual2 = "mob_calculator_tax_rates_anual_2"
    }
}

// MARK: Convenience initializers and mutators

extension CalculatorData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CalculatorData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        status: Int? = nil,
        entity: EntityCalculator? = nil,
        message: JSONNull?? = nil
        ) -> CalculatorData {
        return CalculatorData(
            status: status ?? self.status,
            entity: entity ?? self.entity,
            message: message ?? self.message
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension EntityCalculator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EntityCalculator.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        mobCalculatorAverageAnnualIncome: String? = nil,
        mobCalculatorContributionToHealthFund: String? = nil,
        mobCalculatorContributionToPensionFund: String? = nil,
        mobCalculatorMaxBaseSocialContributions: String? = nil,
        mobCalculatorNonTaxableAmount: String? = nil,
        mobCalculatorPersonalIncomeTax: String? = nil,
        mobCalculatorSalaryTax: String? = nil,
        mobCalculatorSocialContributionsEmployee: String? = nil,
        mobCalculatorSocialContributionsEmployer: String? = nil,
        mobCalculatorStandardCosts: String? = nil,
        mobCalculatorTaxRatesAnual1: String? = nil,
        mobCalculatorTaxRatesAnual2: String? = nil
        ) -> EntityCalculator {
        return EntityCalculator(
            mobCalculatorAverageAnnualIncome: mobCalculatorAverageAnnualIncome ?? self.mobCalculatorAverageAnnualIncome,
            mobCalculatorContributionToHealthFund: mobCalculatorContributionToHealthFund ?? self.mobCalculatorContributionToHealthFund,
            mobCalculatorContributionToPensionFund: mobCalculatorContributionToPensionFund ?? self.mobCalculatorContributionToPensionFund,
            mobCalculatorMaxBaseSocialContributions: mobCalculatorMaxBaseSocialContributions ?? self.mobCalculatorMaxBaseSocialContributions,
            mobCalculatorNonTaxableAmount: mobCalculatorNonTaxableAmount ?? self.mobCalculatorNonTaxableAmount,
            mobCalculatorPersonalIncomeTax: mobCalculatorPersonalIncomeTax ?? self.mobCalculatorPersonalIncomeTax,
            mobCalculatorSalaryTax: mobCalculatorSalaryTax ?? self.mobCalculatorSalaryTax,
            mobCalculatorSocialContributionsEmployee: mobCalculatorSocialContributionsEmployee ?? self.mobCalculatorSocialContributionsEmployee,
            mobCalculatorSocialContributionsEmployer: mobCalculatorSocialContributionsEmployer ?? self.mobCalculatorSocialContributionsEmployer,
            mobCalculatorStandardCosts: mobCalculatorStandardCosts ?? self.mobCalculatorStandardCosts,
            mobCalculatorTaxRatesAnual1: mobCalculatorTaxRatesAnual1 ?? self.mobCalculatorTaxRatesAnual1,
            mobCalculatorTaxRatesAnual2: mobCalculatorTaxRatesAnual2 ?? self.mobCalculatorTaxRatesAnual2
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: Encode/decode helpers

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

