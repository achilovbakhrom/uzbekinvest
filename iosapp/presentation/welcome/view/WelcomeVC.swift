//
//  WelcomeVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class WelcomeVC: BaseGreenVC {
    
    @IBAction func nextButtonClicked(_ sender: Any) {        
        goNext(sender)
    }
    
    @IBOutlet weak var arrowButton: UIImageView!
    @IBOutlet weak var uzbekButton: WhiteBorderedTextButton!
    @IBOutlet weak var russianButton: WhiteBorderedTextButton!
    @IBOutlet weak var englishButton: WhiteBorderedTextButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bottomViewe: UIView!
    
    lazy var welcomePresenter: WelcomePresenterProtocol? = {
        return self.presenter as? WelcomePresenterProtocol        
    }()
    
    @IBOutlet weak var welcome1: UILabel!
    @IBOutlet weak var welcome2: UILabel!
    @IBOutlet weak var welcome3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isIPhone4OrNewer() {
            welcome1.font = UIFont.init(name: "Roboto-Regular", size: 22)
            welcome2.font = UIFont.init(name: "Roboto-Regular", size: 22)
            welcome3.font = UIFont.init(name: "Roboto-Medium", size: 22)
        }
        if isIPhone4OrNewer() {
            descriptionLabel.setLineSpacing(lineSpacing: 4)
        } else if isIPhoneSE() {
            
        } else if isIPhonePlus() {
            
        } else if isIPhoneXOrHigher() {
            
        }
        
        self.welcomePresenter?.languageSelected(lang: Languages.ru.rawValue)
        russianButton.select()
        uzbekButton.unselect()
        englishButton.unselect()
        self.bottomViewe.isUserInteractionEnabled = true
        self.bottomViewe.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(goNextBottom(_:))))
    }
    
    @IBAction func uzbekClicked(_ sender: Any) {
        russianButton.unselect()
        englishButton.unselect()
        uzbekButton.select()
        UserDefaults.standard.set([Languages.uz.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.appDelegate.currentLanguage = Languages.uz.rawValue
        Bundle.swizzleLocalization()
        self.welcomePresenter?.languageSelected(lang: Languages.uz.rawValue)
        self.appDelegate.restartApp()
    }
    
    @IBAction func russianClicked(_ sender: Any) {
        uzbekButton.unselect()
        englishButton.unselect()
        russianButton.select()
        UserDefaults.standard.set([Languages.ru.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.appDelegate.currentLanguage = Languages.ru.rawValue
        Bundle.swizzleLocalization()
        self.welcomePresenter?.languageSelected(lang: Languages.ru.rawValue)
        self.appDelegate.restartApp()
    }
    
    @IBAction func englishClicked(_ sender: Any) {
        uzbekButton.unselect()
        russianButton.unselect()
        englishButton.select()
        UserDefaults.standard.set([Languages.uzCyrl.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.appDelegate.currentLanguage = Languages.uzCyrl.rawValue
        Bundle.swizzleLocalization()
        self.welcomePresenter?.languageSelected(lang: Languages.uzCyrl.rawValue)
        self.appDelegate.restartApp()
    }
    
    @objc
    private func goNext(_ sender: Any) {        
        self.welcomePresenter?.nextButtonClicked()
    }
    
    @objc
    private func goNextBottom(_ gesture: UITapGestureRecognizer) {
        self.welcomePresenter?.nextButtonClicked()
    }
    
}
