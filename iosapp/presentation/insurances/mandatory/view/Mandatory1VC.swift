//
//  Mandatory1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/4/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Mandatory1VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var lt2y: UIButton!
    @IBOutlet weak var f2t5: UIButton!
    @IBOutlet weak var gt5: UIButton!
    @IBOutlet weak var lt22: UIButton!
    @IBOutlet weak var gt22: UIButton!
    
    private lazy var mandatoryPresenter = self.presenter as? MandatoryPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButtonClicked = { self.mandatoryPresenter?.goBack() }
        
        // exp
        lt2y.active()
        f2t5.inactive()
        gt5.inactive()
        self.mandatoryPresenter?.setExperience(exp: 0, expString: lt2y.titleLabel?.text ?? "")
        
        // age
        lt22.active()
        gt22.inactive()
        self.mandatoryPresenter?.setAge(age: 0, ageString: lt22.titleLabel?.text ?? "")
        
        backButtonClicked = { self.mandatoryPresenter?.goBack() }
    }
    
    @IBAction func lt2yClicked(_ sender: Any) {
        lt2y.active()
        f2t5.inactive()
        gt5.inactive()
        self.mandatoryPresenter?.setExperience(exp: 0, expString: lt2y.titleLabel?.text ?? "")
    }
    
    @IBAction func f2t5Clicked(_ sender: Any) {
        lt2y.inactive()
        f2t5.active()
        gt5.inactive()
        self.mandatoryPresenter?.setExperience(exp: 1, expString: f2t5.titleLabel?.text ?? "")
    }
    
    @IBAction func gt5Clicked(_ sender: Any) {
        lt2y.inactive()
        f2t5.inactive()
        gt5.active()
        self.mandatoryPresenter?.setExperience(exp: 2, expString: gt5.titleLabel?.text ?? "")
    }
    
    @IBAction func lt22Clicked(_ sender: Any) {
        lt22.active()
        gt22.inactive()
        self.mandatoryPresenter?.setAge(age: 0, ageString: lt22.titleLabel?.text ?? "")
    }
    
    @IBAction func gt22Clicked(_ sender: Any) {
        lt22.inactive()
        gt22.active()
        self.mandatoryPresenter?.setAge(age: 1, ageString: gt22.titleLabel?.text ?? "")
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.mandatoryPresenter?.openMandatory2()
    }
    
}
