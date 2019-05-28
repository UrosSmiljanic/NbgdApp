//
//  CommonValues.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

struct CommonValues {
    
    static var notFaq: Bool = false
    static var industrialOverview: Bool = false
    static var calculationType: String = ""
    static var currency: String = ""
    static var userInputValue: Double = 0.00
    static var userInputFamily: Double = 0.00
    static var typeOfCalculationView: String = ""
    static var insurance: String = ""
    static var selectedIndustry: Array = [String]()

    static var pdfLink: String = ""

    static var video: Bool = false
    static var notification: Bool = true
    static var currentYear: Int = 0
    static var currentMonth: Int = 0
    static var currentDay: Int = 0
    static var taxCalendar: Bool = false
    static var serbianCalendar: Array = ["Јануар", "Фебруар", "Март", "Април", "Мај", "Јун", "Јул", "Август", "Септембар", "Октобар", "Новембар", "Децембар"]
    static var englisCalendar: Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    static var eurSelected: Bool = false
    static var eurValue: Double = 0.00
    static var firstTimeEuEvents: Bool = true
}
