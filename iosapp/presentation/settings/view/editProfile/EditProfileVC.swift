//
//  EditProfileVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class EditProfileVC: BaseViewImpl {
    let editProfileView: EditProfileView = EditProfileView.fromNib()
    let loadingView: LoadingView = LoadingView.fromNib()
    
    
    private lazy var settingsPresenter = self.presenter as? SettingsPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(editProfileView)
        editProfileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.editProfileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.editProfileView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.editProfileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.editProfileView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        loadingView.layer.opacity = 0.0
        editProfileView.nameLabel.onChange = {
            self.settingsPresenter?.setName(name: $0)
        }
        editProfileView.dobPicker.onChange = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.settingsPresenter?.setDob(dob: formatter.string(from: $0))
        }
        editProfileView.regionDropDown.didSelect { (_, _, id) in
            self.settingsPresenter?.setRegion(regionId: id)
        }
        editProfileView.addressTextField.onChange = {
            self.settingsPresenter?.setAddress(address: $0)
        }
        editProfileView.onBack = { self.settingsPresenter?.goBack() }
        editProfileView.onChange = {
            self.settingsPresenter?.updateUser()
        }
        self.settingsPresenter?.fetchMe()
    }
    
    func setLoading(isLoading: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
    }
    
    func setEnabled(isEnabled: Bool) {
        self.editProfileView.changeButton.isEnabled = isEnabled
    }
    
    func setRegions(regionList: [Region]) {
        self.editProfileView.regionDropDown.optionIds = regionList.map({ $0.id })
        self.editProfileView.regionDropDown.optionArray = regionList.map({  $0.name })
        self.editProfileView.regionDropDown.didSelect { (_, _, id) in
            self.settingsPresenter?.setRegion(regionId: id)
        }
    }
    
    func setMe(user: User) {
        self.editProfileView.nameLabel.text = user.name
        self.editProfileView.dobPicker.text = user.dob
        self.editProfileView.regionDropDown.text = user.region?.name
        self.editProfileView.addressTextField.text = user.address
    }
}

