//
//  SettingsPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

protocol SettingsPresenter: BasePresenter {
    
    func goBack()
    func openEditProfile()
    func setMe(user: User)
    func updateUser()
    func setName(name: String)
    func setDob(dob: String)
    func setRegion(regionId: Int)
    func setAddress(address: String)
    func fetchMe()
    func setLoading(isLoading: Bool)
    func setEnabled(isEnabled: Bool)
    func logout()
    func setRegions(regionList: [Region])
    func showError(msg: String)
    func updateProfile()
    func openAddByPinfl()
    func fetchPinflList()
    func setPinflList(list: [Pinfl])
    func removePinfl(pinfl: Int)
    func openPinflListVC()
    func setLanguage(language: String)
}


class SettingsPresenterImpl: SettingsPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var view: UIViewController?
    private lazy var settingsInteractor = self.interactor as? SettingsInteractor
    private lazy var settingsRouter = self.router as? SettingsRouter
    var user = UserRequest()
    
    func goBack() {
        self.settingsRouter?.goBack()
    }
    
    func openEditProfile() {
        self.settingsRouter?.openEditProfileVC()
    }
    
    func setMe(user: User) {
        self.user.name = user.name
        self.user.dob = user.dob
        self.user.region_id = user.region?.id ?? nil
        self.user.address = user.address
        self.user.phone = user.phone
        if let vc = self.view as? EditProfileVC {
            vc.setMe(user: user)
        }
    }
    
    func updateUser() {
        self
            .settingsInteractor?
            .updateUser(user: self.user)
    }
    
    func updateProfile() {
        if let nc = self.view?.tabBarController?.viewControllers?[3] as? UINavigationController, let profileVC = nc.viewControllers[0] as? MainProfileVC {
            profileVC.reloadData()
        }
    }
    
    func setName(name: String) {
        self.user.name = name
    }
    
    func setDob(dob: String) {
        self.user.dob = dob
    }
    
    func setRegion(regionId: Int) {
        self.user.region_id = regionId
    }
    
    func setAddress(address: String) {
        self.user.address = address
    }
    
    func fetchMe() {
        self.settingsInteractor?.fetchMe()
    }
    
    func setLoading(isLoading: Bool) {
        if let vc = self.view as? EditProfileVC {
            vc.setLoading(isLoading: isLoading)
        } else if let vc = self.view as? PinflVC {
            vc.setLoading(isLoading: isLoading)
        }
    }
    
    func setEnabled(isEnabled: Bool) {
        if let vc = self.view as? EditProfileVC {
            vc.setEnabled(isEnabled: isEnabled)
        }
    }
    
    func logout() {
        let phone = self.settingsInteractor?.clearProfileAndgetPhoneNumber() ?? ""
        self.settingsRouter?.openLoginVC(phone: phone)
    }
    
    
    func setRegions(regionList: [Region]) {
        if let vc = self.view as? EditProfileVC {
            vc.setRegions(regionList: regionList)
        }
    }
    
    func showError(msg: String) {
        if let vc = self.view as? BaseViewImpl {
            vc.showErrorMessage(msg: msg)
        }
    }
    
    func openAddByPinfl() {
        if let b = self.settingsInteractor?.getShowAgainFlag() {
            if b {
                self.settingsRouter?.openAddInsurancePage()                
            } else {
                self.settingsRouter?.openAddInsuranceInstructionPage()
            }
        } else {
            self.settingsRouter?.openAddInsuranceInstructionPage()            
        }
    }
    
    func fetchPinflList() {
        self.settingsInteractor?.fetchPinfl()
    }
    
    func setPinflList(list: [Pinfl]) {
        if let vc = self.view as? PinflVC {
            vc.setPinflList(list: list)
        }
    }
    
    func removePinfl(pinfl: Int) {
        self.settingsInteractor?.removePinfl(id: pinfl)
    }
    
    func openPinflListVC() {
        self.settingsRouter?.openPinflListVC()
    }
    
    func setLanguage(language: String) {
        self.settingsInteractor?.setLanguage(lang: language)
    }
    
}
