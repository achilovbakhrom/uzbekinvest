//
//  Home1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Home1VC: BaseWithRightGreenCirclesVC {
    
    @IBOutlet weak var type1: UIButton!
    @IBOutlet weak var type2: UIButton!
    @IBOutlet weak var type3: UIButton!
    @IBOutlet weak var type4: UIButton!
    
    private lazy var homePresenter = self.presenter as? HomePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type1.active()
        type2.inactive()
        type3.inactive()
        type4.inactive()
        backButtonClicked = {
            self.homePresenter?.goBack()
            self.setTabBarHidden(false)
        }
        self.homePresenter?.setType(type: 0, typeString: type1.titleLabel?.text ?? "")
        self.setTabBarHidden(true)
    }
    
    @IBAction func type1Clicked(_ sender: Any) {
        type1.active()
        type2.inactive()
        type3.inactive()
        type4.inactive()
        self.homePresenter?.setType(type: 0, typeString: type1.titleLabel?.text ?? "")
    }
    
    @IBAction func type2Clicked(_ sender: Any) {
        type1.inactive()
        type2.active()
        type3.inactive()
        type4.inactive()
        self.homePresenter?.setType(type: 1, typeString: type2.titleLabel?.text ?? "")
    }
    
    @IBAction func type3Clicked(_ sender: Any) {
        type1.inactive()
        type2.inactive()
        type3.active()
        type4.inactive()
        self.homePresenter?.setType(type: 2, typeString: type3.titleLabel?.text ?? "")
    }
    
    @IBAction func type4Clicked(_ sender: Any) {
        type1.inactive()
        type2.inactive()
        type3.inactive()
        type4.active()
        self.homePresenter?.setType(type: 3, typeString: type4.titleLabel?.text ?? "")
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.homePresenter?.openHomeConfirmVC()
    }
    
}
