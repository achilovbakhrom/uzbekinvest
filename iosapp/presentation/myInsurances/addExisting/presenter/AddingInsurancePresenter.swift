//
//  AddingPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol AddingInsurancePresenter: BasePresenter {
    func openAddExistingInsurancePage()
    func openInstructionsPage()
    func setShowAgain(isShowAgain: Bool)
    func addByPinFl()
    func setupInstructionPage()
    func goBack()
    func goToMainPage()
    func addInsuranceBackPressed()
    func showError(msg: String)
    func setPinfl(pinfl: String)
    func setLoading(isLoading: Bool)
    func setupSwitcher()
}

class AddingInsurancePresenterImpl: AddingInsurancePresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    var pinfl: String = ""
    private lazy var addInsuranceInteractor = self.interactor as? AddInsuranceInteractor
    private lazy var addInsuranceRouter = self.router as? AddInsuranceRouter
    
    func setupInstructionPage() {
        let vc = self.view as? AddingInstructionVC
        if let b = self.addInsuranceInteractor?.getShowAgainFlag(), b {
            vc?.setShowAgainButtonChecked(isChecked: b)                        
        } else {
            vc?.setShowAgainButtonChecked(isChecked: false)
        }
    }
    
    func openAddExistingInsurancePage() {
        self.addInsuranceRouter?.openAddExistingInsurancePage()
    }
    
    func setShowAgain(isShowAgain: Bool) {
        self.addInsuranceInteractor?.setShowAgainFlag(isShowAgain: isShowAgain)
    }
    
    func addByPinFl() {
        self
            .addInsuranceInteractor?
            .addPinfl(pinfl: Pinfl.init(id: nil, pinfl: self.pinfl))
        
    }
    
    
    func setPinfl(pinfl: String) {
        self.pinfl = pinfl
        if let vc = self.view as? AddingInsuranceVC {
            vc.setEnabled(isEnabled: self.pinfl.count == 14)
        }
    }
    
    func goToMainPage() {
        self.addInsuranceRouter?.goToMainPage()
    }
    
    func goBack() {
        var found = false
        let vcs = self.view?.navigationController?.viewControllers ?? []
        vcs.forEach { vc in
            if vc is PinflVC {
                found = true
            }
        }
//        if !found {
//            self.view?.setTabBarHidden(false)
//        }
        
        self.addInsuranceRouter?.goBack()
    }
    
    func addInsuranceBackPressed() {
        if let b = self.addInsuranceInteractor?.getShowAgainFlag(), !b {
            self.addInsuranceRouter?.goToMainPage()
        } else {
            self.addInsuranceRouter?.goBack()
        }
    }
    func showError(msg: String) {
        if let vc = self.view as? AddingInsuranceVC {
            vc.showErrorMessage(msg: msg)
        }
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? AddingInsuranceVC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func setupSwitcher() {
        if let b = self.addInsuranceInteractor?.getShowAgainFlag(), b {
            self.addInsuranceRouter?.openInsurancePageFromSwitcher()
        } else {
            self.addInsuranceRouter?.openInstructionPageFromSwitcher()
        }
    }
    
    func openInstructionsPage() {
        self.addInsuranceRouter?.openInstruction()
    }
    
    
}
