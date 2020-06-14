//
//  SettingsVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class SettingsVC: BaseViewImpl {
    
    let settingsView: SettingsView = SettingsView.fromNib()
    lazy var settingsPresenter = self.presenter as? SettingsPresenter
    private lazy var noInternetView: NoInternetView = NoInternetView.fromNib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(settingsView)
        self.settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.settingsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.settingsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.settingsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.settingsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.settingsView.onBackClick = {
            self.setTabBarHidden(false)
            self.settingsPresenter?.goBack()
        }
        
        self.settingsView.onProfileClick = {
            self.settingsPresenter?.openEditProfile()
        }
        
        self.settingsView.onPinflClick = {
            self.settingsPresenter?.openPinflListVC()
        }
        
        self.settingsView.onExitClick = {
            self.settingsPresenter?.logout()
        }
        
        self.settingsView.onLanguageClick = {
            let alertC = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            let languageView = SwitchLanguageView.init(frame: .zero)
            languageView.translatesAutoresizingMaskIntoConstraints = false
            alertC.view.addSubview(languageView)
            NSLayoutConstraint.activate([
                languageView.leadingAnchor.constraint(equalTo: alertC.view.leadingAnchor),
                languageView.topAnchor.constraint(equalTo: alertC.view.topAnchor),
                languageView.trailingAnchor.constraint(equalTo: alertC.view.trailingAnchor),
                languageView.bottomAnchor.constraint(equalTo: alertC.view.bottomAnchor)
            ])
            
            languageView.onRussian = {
                UserDefaults.standard.set([Languages.ru.rawValue], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                self.appDelegate.currentLanguage = Languages.ru.rawValue
                Bundle.swizzleLocalization()
                self.settingsPresenter?.setLanguage(language: "ru")
                self.appDelegate.restartApp()
                self.dismiss(animated: true, completion: nil)
            }
            
            languageView.onUzbek = {
                UserDefaults.standard.set([Languages.uz.rawValue], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                self.appDelegate.currentLanguage = Languages.uz.rawValue
                Bundle.swizzleLocalization()
                self.settingsPresenter?.setLanguage(language: "uz-UZ")
                
                self.appDelegate.restartApp()
                self.dismiss(animated: true, completion: nil)
            }
            
            languageView.onUzbekCyrl = {
                UserDefaults.standard.set([Languages.uzCyrl.rawValue], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                self.appDelegate.currentLanguage = Languages.uzCyrl.rawValue
                Bundle.swizzleLocalization()
                self.settingsPresenter?.setLanguage(language: "uz-Cyrl")
                self.appDelegate.restartApp()
                self.dismiss(animated: true, completion: nil)
            }
            
            self.present(alertC, animated: true, completion: {
                alertC.view.superview?.isUserInteractionEnabled = true
                alertC.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped(tapGesture:))))
            })
        }
        
        
        switch translatePosition {
        case 0:
            self.settingsView.currentLanguate = "Русский"
            break
        case 1:
            self.settingsView.currentLanguate = "O'zbekcha"
            break
        case 2:
            self.settingsView.currentLanguate = "Узбекча"
            break
        default:
            self.settingsView.currentLanguate = "Русский"
            break
        }
        self.setTabBarHidden(true)
    }
    
    @objc func alertControllerBackgroundTapped(tapGesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}



