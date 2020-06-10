//
//  MyInsurancesPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/8/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol MyInsurancesPresenter: BasePresenter {
    func fetchMyInsurances()
    func openLoginVC(phone: String)
    func setLoading(isLoading: Bool)
    func setCategoryList(categoryList: [Category])
    func setMyInsurances(myInsuranceList: [MyInsurance], properties: [MyInsuranceProperties])
    func setPinflOrders(pinflOrders: [MyInsurance])
    func categorySelected(category: Category)
    func insuranceSelected(myInsurance: MyInsurance, property: MyInsuranceProperties)
    func openAddInsurancePage()
    func goBack()
    func openAddMyInsuranceVC()
    func openInsuranceListVC()
    
}

class MyInsurancesPresenterImpl: MyInsurancesPresenter {
    
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    
    private var myInsuranceList = [MyInsurance]()
    private var pinflOrders = [MyInsurance]()
    private var categoryList = [Category]()
    private var myInsurance: MyInsurance!
    private var properties: [MyInsuranceProperties] = []
    
    private lazy var myInsrancesInteractor = self.interactor as? MyInsurancesInteractor
    private lazy var myInsrancesRouter = self.router as? MyInsurancesRouter
    private lazy var myInsrancesView = self.view as? MyInsuranceVC
    
    func fetchMyInsurances() {
        myInsrancesInteractor?.fetchMyInsurances()
    }
    
    func openLoginVC(phone: String) {
        myInsrancesRouter?.openLoginVC(phone: phone)
    }
    
    
    private func setEmptyMode(isEmpty: Bool) {
        if isEmpty {
            myInsrancesView?.setEmptyMode()
        } else {
            myInsrancesView?.setListingMode()
        }
    }
    
    func setLoading(isLoading: Bool) {
        myInsrancesView?.setLoading(isLoading: isLoading)
    }
    
    func setCategoryList(categoryList: [Category]) {
        self.categoryList = categoryList        
        self.myInsrancesView?.setCategoryList(categoryList: categoryList)
    }
    
    func setMyInsurances(myInsuranceList: [MyInsurance], properties: [MyInsuranceProperties]) {
        self.properties = properties
        self.myInsuranceList = myInsuranceList
        self.setEmptyMode(isEmpty: self.myInsuranceList.isEmpty)
        self.myInsrancesView?.setMyInsurancesList(myInsurancesList: myInsuranceList, properties: properties)
    }
    
    func categorySelected(category: Category) {
        if category.id == -1 {
            self.myInsrancesView?.setMyInsurancesList(myInsurancesList: myInsuranceList, properties: properties)
        } else if category.id == -2 {
            self.myInsrancesView?.setMyInsurancesList(myInsurancesList: pinflOrders, properties: [])
        } else {
            let p = properties.filter { prop in
                let index = self.properties.firstIndex(of: prop)
                return self.myInsuranceList[index ?? 0].product?.category?.id == category.id
            }
            self.myInsrancesView?.setMyInsurancesList(myInsurancesList: myInsuranceList.filter({ $0.product?.category?.id == category.id}), properties: p)
        }
    }
    
    func insuranceSelected(myInsurance: MyInsurance, property: MyInsuranceProperties) {
        self.myInsurance = myInsurance
        var prop = [String: String]()
        
        let p = property.properties;
        
        switch myInsurance.product?.name {
        case "osago":
            if let period = p["period"] as? String {
                switch period {
                case "15 days":
                    prop["periods_of_insurance".localized()] = "for_15_days".localized()
                case "2 months":
                    prop["periods_of_insurance".localized()] = "for_2_months".localized()
                case "12 months":
                    prop["periods_of_insurance".localized()] = "for_12_months".localized()
                case "20 days":
                    prop["periods_of_insurance".localized()] = "for_20_days".localized()
                case "6 months":
                    prop["periods_of_insurance".localized()] = "for_6_months".localized()
                default:
                    prop["periods_of_insurance".localized()] = ""
                }
            }
            if let isForeigner = p["is_foreigner"] as? Int {
                if isForeigner == 1 {
                    prop["citizenship".localized()] = "foreign_citizen".localized()
                } else {
                    prop["citizenship".localized()] = "citizen_of_the_republic_of_uzbekistan".localized()
                }
            }
            if let isUnlim = p["is_unlim"] as? Int {
                if isUnlim == 1 {
                    prop["authorized_persons_to_control_the_vehicle".localized()] = "unlim".localized()
                } else {
                    prop["citizenship".localized()] = "citizen_of_the_republic_of_uzbekistan".localized()
                }
            }
            
            if let accident = p["accident"] as? Int {
                prop["authorized_persons_to_control_the_vehicle".localized()] = "\(accident.toDecimalFormat()) \("sum".localized())"
            }
            
            if let isInvalid = p["is_invalid"] as? Int {
                if isInvalid == 1 {
                    prop["people_with_disabilities".localized()] = "yes".localized()
                } else {
                    prop["people_with_disabilities".localized()] = "no".localized()
                }
            }
            
            if let isInvalid = p["is_invalid"] as? Int {
                if isInvalid == 1 {
                    prop["people_with_disabilities".localized()] = "yes".localized()
                } else {
                    prop["people_with_disabilities".localized()] = "no".localized()
                }
            }
            
            if let isRetired = p["is_retired"] as? Int {
                if isRetired == 1 {
                    prop["pensionery".localized()] = "yes".localized()
                } else {
                    prop["pensionery".localized()] = "no".localized()
                }
            }
            break
        case "kasko":
            break
        case "my-life":
            
            if let type = p["type"] as? Int {
                if type == 0 {
                    prop["type_of_insurance".localized()] = "standart".localized()
                } else if type == 1 {
                    prop["type_of_insurance".localized()] = "premium".localized()
                } else if type == 2 {
                    prop["type_of_insurance".localized()] = "gold".localized()
                } else {
                    prop["type_of_insurance".localized()] = "kasko_new_version".localized()
                }
            }
            
            if let period = p["period"] as? Double {
                if period == 0.25 {
                    prop["periods_of_insurance".localized()] = "for_3_months".localized()
                } else if period == 0.5 {
                    prop["periods_of_insurance".localized()] = "for_6_months".localized()
                } else if period == 0.75 {
                    prop["periods_of_insurance".localized()] = "for_9_months".localized()
                } else if period == 1.0 {
                    prop["type_of_insurance".localized()] = "for_a_year".localized()
                } else if period == 2.0 {
                    prop["type_of_insurance".localized()] = "for_2_years".localized()
                } else if period == 3.0 {
                    prop["type_of_insurance".localized()] = "for_3_years".localized()
                } else if period == 4.0 {
                    prop["type_of_insurance".localized()] = "for_4_years".localized()
                } else if period == 5.0 {
                    prop["type_of_insurance".localized()] = "for_5_years".localized()
                }
            }
            
            if let carPrice = p["car_price"] as? Int {
                prop["amount_of_car".localized()] = "\(carPrice.toDecimalFormat()) \("sum".localized())"
            }
            
            break;
        case "pledged-transport":
            if let age = p["age"] as? Int {
                if age == 0 {
                    prop["age".localized()] = "less_than_22".localized()
                } else {
                    prop["age".localized()] = "more_than_22".localized()
                }
            }
            if let experience = p["experience"] as? Int {
                if experience == 0 {
                    prop["experience".localized()] = "less_than_2_years".localized()
                } else if experience == 1  {
                    prop["experience".localized()] = "two_to_five_years".localized()
                } else {
                    prop["experience".localized()] = "more_than_5_years".localized()
                }
            }
            break
        case "my-family":
            if let type = p["type"] as? String {
                switch type {
                case "0":
                    prop["insurance_cost".localized()] = "million_25".localized()
                case "1":
                    prop["insurance_cost".localized()] = "million_75".localized()
                case "2":
                    prop["insurance_cost".localized()] = "million_125".localized()
                case "3":
                    prop["insurance_cost".localized()] = "million_250".localized()
                default:
                    prop["insurance_cost".localized()] = "million_25".localized()
                }
            }
            break
        case "pledged-property":
            if let years = p["years"] as? Int {
                prop["number_of_years".localized()] = years.toDecimalFormat()
            }
            break
        case "health-insurance":
            if let type = p["type"] as? Int {
                if type == 0 {
                    prop["program".localized()] = "classic".localized()
                } else if type == 1 {
                    prop["program".localized()] = "prestige".localized()
                } else if type == 2 {
                    prop["program".localized()] = "prestige_plus".localized()
                }
            }
            
            if let age = p["age"] as? Int {
                if age == 0 {
                    prop["age".localized()] = "up_to_3_years".localized()
                } else if age == 1 {
                    prop["age".localized()] = "from_3_to_7_years_old".localized()
                } else if age == 2 {
                    prop["age".localized()] = "from_7_to_16_years_old".localized()
                } else if age == 3 {
                    prop["age".localized()] = "from_16_to_35_years_old".localized()
                } else if age == 4 {
                    prop["age".localized()] = "from_35_to_45_years_old".localized()
                } else if age == 5 {
                    prop["age".localized()] = "from_45_to_55_years_old".localized()
                } else if age == 6 {
                    prop["age".localized()] = "from_55_to_70_years_old".localized()
                } else if age == 7 {
                    prop["age".localized()] = "from_70_years_old".localized()
                } else {
                    prop["age".localized()] = ""
                }
            }
            
            break
        case "my-health":            
            if let type = p["type"] as? Int {
                if type == 0 {
                    prop["safety_amount".localized()] = "1 000 000 \("sum".localized())"
                } else if type == 1 {
                    prop["safety_amount".localized()] = "2 000 000 \("sum".localized())"
                } else if type == 2 {
                    prop["safety_amount".localized()] = "3 000 000 \("sum".localized())"
                } else if type == 3 {
                    prop["safety_amount".localized()] = "4 000 000 \("sum".localized())"
                } else if type == 4 {
                    prop["safety_amount".localized()] = "5 000 000 \("sum".localized())"
                } else if type == 5 {
                    prop["safety_amount".localized()] = "6 000 000 \("sum".localized())"
                } else if type == 6 {
                    prop["safety_amount".localized()] = "7 000 000 \("sum".localized())"
                }  else if type == 7 {
                    prop["safety_amount".localized()] = "8 000 000 \("sum".localized())"
                } else if type == 8 {
                    prop["safety_amount".localized()] = "9 000 000 \("sum".localized())"
                } else if type == 9 {
                    prop["safety_amount".localized()] = "10 000 000 \("sum".localized())"
                }
            }
            break
        case "travel":
            if let plan = p["plan"] as? Int {
                if plan == 0 {
                    prop["rate".localized()] = "rate_standart".localized()
                } else if plan == 1 {
                    prop["rate".localized()] = "rate_comfort".localized()
                } else if plan == 2 {
                    prop["rate".localized()] = "rate_premium".localized()
                }
            }
            
            if let type = p["type"] as? Int {
                if type == 0 {
                    prop["rate".localized()] = "one_time".localized()
                } else if type == 1 {
                    prop["rate".localized()] = "multiple".localized()
                }
            }
            
            if let program = p["program"] as? Int {
                if program == 0 {
                    prop["program_multi".localized()] = "travel_multiple_type0_text".localized()
                } else if program == 1 {
                    prop["program_multi".localized()] = "travel_multiple_type1_text".localized()
                } else if program == 2 {
                    prop["program_multi".localized()] = "travel_multiple_type2_text".localized()
                } else if program == 3 {
                    prop["program_multi".localized()] = "travel_multiple_type4_text".localized()
                } else if program == 4 {
                    prop["program_multi".localized()] = "travel_multiple_type0_text".localized()
                }
            }
            
            if let c = p["class"] as? String {
                prop["purpose_of_the_trip".localized()] = "class - \(c)"
            }
            break
        case "sport-accident":
            
            if let isComp = p["is_competition"] as? Int {
                if isComp == 0 {
                    prop["only_during_the_competition".localized()] = "no".localized()
                } else if isComp == 1 {
                    prop["only_during_the_competition".localized()] = "yes".localized()
                }
            }
            
            if let period = p["competition_period"] as? Int {
                if period == 0 {
                    prop["competition_period".localized()] = "9 \("days".localized())"
                } else if period == 1 {
                    prop["competition_period".localized()] = "14 \("days".localized())"
                } else if period == 2 {
                    prop["competition_period".localized()] = "29 \("days".localized())"
                } else if period == 3 {
                    prop["competition_period".localized()] = "365 \("days".localized())"
                }
            }
            
            if let q15 = p["quantity_lt_15"] as? Int {
                prop["\("number_of_participants".localized()) \("up_to_15_years".localized())"] = q15.toDecimalFormat()
            }
            
            
            if let lt18 = p["quantity_lt_18"] as? Int {
                prop["\("number_of_participants".localized()) \("up_to_18_years".localized())"] = lt18.toDecimalFormat()
            }
            
            if let lt30 = p["quantity_lt_30"] as? Int {
                prop["\("number_of_participants".localized()) \("quantity_lt_30".localized())"] = lt30.toDecimalFormat()
            }
            
            if let mt30 = p["quantity_lt_30"] as? Int {
                prop["\("number_of_participants".localized()) \("over_30_years".localized())"] = mt30.toDecimalFormat()
            }
            break
        case "technical-help":
            if let type = p["type"] as? Int {
                prop["safety_amount".localized()] = "\(type.toDecimalFormat()) \("sum".localized())"
            }
            break
        case "gas-home":
            
            if let type = p["type"] as? Int {
                if type == 0 {
                    prop["program".localized()] = "home".localized()
                } else if type == 1 {
                    prop["program".localized()] = "third_parties".localized()
                }
            }
            
            if let franchise = p["franchise"] as? Int {
                if franchise == 0 {
                    prop["type_service".localized()] = "no_franchise".localized()
                } else if franchise == 1 {
                    prop["type_service".localized()] = "franchise_up_to".localized()
                } else if franchise == 2 {
                    prop["type_service".localized()] = "franchise_over".localized()
                }
            }
            
            break
        case "gas-auto":
            if let firstTypeParty = p["first_party_type"] as? Int {
                prop["program".localized()] = "gas_equipment".localized()
                if firstTypeParty == 0 {
                    prop["type".localized()] = "car".localized()
                } else {
                    prop["type".localized()] = "other".localized()
                }
            } else {
                prop["program".localized()] = "third_parties".localized()
            }
            
            if let firstPartyAmount = p["first_party_amount"] as? Int, firstPartyAmount != 0 {
                prop["safety_amount".localized()] = "\(firstPartyAmount.toDecimalFormat()) \("sum".localized())"
            }
            
            if let thirdPartyAmount = p["third_party_amount"] as? Int, thirdPartyAmount != 0 {
                prop["safety_amount".localized()] = "\(thirdPartyAmount.toDecimalFormat()) \("sum".localized())"
            }
            break
        case "infectious-disease":
            if let q7 = p["quantity_lt_7"] as? Int {
                prop["\("number_of_participants".localized()) \("quantity_lt_7".localized())"] = q7.toDecimalFormat()
            }
            
            if let q60 = p["quantity_lt_60"] as? Int {
                prop["\("number_of_participants".localized()) \("up_to_60_years".localized())"] = q60.toDecimalFormat()
            }
            
            if let qm60 = p["quantity_lt_60"] as? Int {
                prop["\("number_of_participants".localized()) \("quantity_lt_7".localized())"] = qm60.toDecimalFormat()
            }
            break
        case "mobile-phone":
            if let phonePrice = p["phone_price"] as? Int {
                prop["mobile_phone_cost".localized()] = "\(phonePrice.toDecimalFormat()) \("sum".localized())"
            }
            break
        case "luggage-out":
            if let days = p["days"] as? Int {
                prop["mobile_phone_cost".localized()] = days.toDecimalFormat()
            }
            break
        default:
            break
        }
        
        myInsrancesRouter?.openMyInsuranceDetail(myInsurance: myInsurance, property: prop)
    }
    
    func openAddInsurancePage() {
        self.myInsrancesRouter?.openAddInsuranceInstructionPage()
//        if let b = self.myInsrancesInteractor?.getShowAgainFlag(), !b {
//            self.myInsrancesRouter?.openAddInsurancePage()
//        } else {
//            self.myInsrancesRouter?.openAddInsuranceInstructionPage()
//        }
    }
    
    func setPinflOrders(pinflOrders: [MyInsurance]) {
        self.pinflOrders = pinflOrders
    }
    
    func goBack() {
        self.myInsrancesRouter?.goBack()
    }
    
    func openAddMyInsuranceVC() {
        self.myInsrancesRouter?.openAddMyInsuranceVC()
    }
    
    func openInsuranceListVC() {
        self.myInsrancesRouter?.openInsuranceListVC()
    }
}
