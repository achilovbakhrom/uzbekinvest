//
//  SwitcherVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class SwitcherVC: BaseViewImpl {
    
    private lazy var addExistingPresenter = self.presenter as? AddingInsurancePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.setTabBarHidden(true)
        self.addExistingPresenter?.setupSwitcher()
    }
}
