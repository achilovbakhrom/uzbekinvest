//
//  Registration2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Registration2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var regions: DDown!
    
    @IBOutlet weak var nextButton: Button!
    
    
    private lazy var registrationPresenter: RegistrationPresenter = self.presenter as! RegistrationPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.registrationPresenter.goBack() }
        registrationPresenter.setup2()
        regions.didSelect { (_, _, id) in
            self.registrationPresenter.setRegion(region: id)
        }
    }
    
    @IBAction func adressChanged(_ sender: Any) {
        if let tf = sender as? TextField {
            self.registrationPresenter.setAddress(address: tf.text ?? "")
        }
        
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.registrationPresenter.sendCode()
    }
    
    
    func setEnabled(enabled: Bool) {
        nextButton.isEnabled = enabled
    }
    
    func setLoading(isLoading: Bool) {
        nextButton.isLoading = isLoading
    }
    
    func setRegions(list: [Region]) {
        regions.optionArray = list.map{ $0.name }
        regions.optionIds = list.map { $0.id }
    }
    
}
