//
//  SportPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol SportsPresenter {
    // router
    func openSport1VC()
    func openSport2VC()
    func openSport3VC()
    func openSport4VC()
    func openSportConfirmVC()
    func openSportFinalVC()
    func goBack()
    
    //interactor
    func calculateSports()
    func fetchSports()
    func setSports(ids: [Int], array: [String])
    func setTotalAmount(totalAmount: String)
    
    //presenter
    func setSportId(id: Int, sportString: String)
    func setInsuranceAmount(insuranceAmount: Int)
    func setLt15(count: Int)
    func setLt18(count: Int)
    func setLt30(count: Int)
    func setMte30(count: Int)
    func setIsCompetitionPeriod(isCompetitionPeriod: Bool)
    func setPeriod(perdiod: Int, periodString: String)
    func setEnabled(isEnabled: Bool)
    func setLoading(isLoading: Bool)
    func fillConfirmData()
    
    func setProduct(product: Product)
    func applyInsuranceClicked()
    func openLoginVC(phone: String)
    
}

class SportsPresenterImpl: BaseInsurancePresenter, SportsPresenter {
        
    private lazy var sportsRouter = self.router as? SportsRouter
    private lazy var sportInteractor = self.interactor as? SportInteractor
    private var sportString = ""
    private var periodString = ""
    var sport: Sport
    
    override init() {
        sport = Sport()
    }
    
    func openSport1VC() {
        self.sportsRouter?.openSport1VC()
    }
    
    func openSport2VC() {
        self.sportsRouter?.openSport2VC()
    }
    
    func openSport3VC() {
        self.sportsRouter?.openSport3VC()
    }
    
    func openSport4VC() {
        self.sportsRouter?.openSport4VC()
    }
    
    func openSportConfirmVC() {
        self.sportsRouter?.openSportConfirmVC()
    }
    
    func openSportFinalVC() {
        self.sportsRouter?.openFinalVC()
    }
    
    func calculateSports() {
        self.sportInteractor?.calculateSport(sport: self.sport)
    }
    
    func fetchSports() {
        self.sportInteractor?.fetchSportList()
    }
    
    func setSports(ids: [Int], array: [String]) {
        let vc = self.view as? Sport1VC
        vc?.setSports(ids: ids, array: array)
    }
    
    func setSportId(id: Int, sportString: String) {
        self.sport.sportId = id
        self.sportString = sportString
        self.setEnabled(isEnabled: true)
    }
    
    func setInsuranceAmount(insuranceAmount: Int) {
        self.sport.insuranceAmount = insuranceAmount
        self.setEnabled(isEnabled: true)
    }
    
    private func hasMember() -> Bool {
        return self.sport.quantityLt15 != 0 || self.sport.quantityLt18 != 0 || self.sport.quantityLt30 != 0 || self.sport.quantityMte30 != 0
    }
    
    func setLt15(count: Int) {
        self.sport.quantityLt15 = count
        self.setEnabled(isEnabled: hasMember())
    }
    
    func setLt18(count: Int) {
        self.sport.quantityLt18 = count
        self.setEnabled(isEnabled: hasMember())
    }
    
    func setLt30(count: Int) {
        self.sport.quantityLt30 = count
        self.setEnabled(isEnabled: hasMember())
    }
    
    func setMte30(count: Int) {
        self.sport.quantityMte30 = count
        self.setEnabled(isEnabled: hasMember())
    }
    
    func setIsCompetitionPeriod(isCompetitionPeriod: Bool) {
        self.sport.isCompetition = isCompetitionPeriod
        
        if isCompetitionPeriod {
            self.setEnabled(isEnabled: self.sport.competitionPeriod != -1)
        } else {
            self.setEnabled(isEnabled: true)
        }
    }
    
    func setPeriod(perdiod: Int, periodString: String) {
        self.sport.competitionPeriod = perdiod
        self.periodString = periodString
        self.setEnabled(isEnabled: true)
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? Sport1VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Sport2VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Sport3VC {
            vc.setEnabled(isEnabled: isEnabled)
        } else if let vc = self.view as? Sport4VC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? Sport1VC {
            vc.setLoading(isLoading: isLoading)
        } else if let vc = self.view as? SportConfirmVC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func fillConfirmData() {
        if let vc = self.view as? SportConfirmVC {
            vc.setSport(sport: sportString)
            vc.setInsuranceAmount(insuranceAmount: "\(self.sport.insuranceAmount.toDecimalFormat()) сум")
            let membersCount = sport.quantityLt15 + sport.quantityLt18 + sport.quantityLt30 + sport.quantityMte30
            vc.setMemebersCount(membersCount: "\(membersCount)")
            vc.setPeriod(period: periodString)
        }
    }
    
    func setTotalAmount(totalAmount: String) {
        if let vc = self.view as? SportConfirmVC {
            vc.setTotalAmount(totalAmount: totalAmount)
        }
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    
    func applyInsuranceClicked() {
        self.sportInteractor?.prepareToOpenFinalVC(id: product?.id ?? 0)
    }
    
    override func confirmButtonClicked() {
        self.sportInteractor?.createInsurance(type: .sport, params: sport.dictionary!, amount: nil, startDate: startDate, paymentMethod: paymentType, regionId: regionId, mainFiles: mainFiles, membersCount: membersCount, secondaryFils: secondaryFiles)
    }
}
