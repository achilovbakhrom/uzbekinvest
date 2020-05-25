//
//  Osago1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Osago1VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var uzbCitizen: UIButton!
    @IBOutlet weak var foreignCitizen: UIButton!
    @IBOutlet weak var regionList: DDown!
    
    @IBOutlet weak var nextButton: Button!
    
    private lazy var osagoPresenter: OsagoPresenter = self.presenter as! OsagoPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        osagoPresenter.setIsForeigner(isForeigner: false)
        uzbCitizen.active()
        foreignCitizen.inactive()
        osagoPresenter.fetchRegions()
        regionList.isEnabled = false
        regionList.isSearchEnable = false
        self.regionList.didSelect { (name,_,id) in
            self.osagoPresenter.setRegionId(regionId: id, regionName: name)
        }
        self.backButtonClicked = {
            self.osagoPresenter.goBack()
        }
    }
    
    @IBAction func uzbCitizenClicked(_ sender: Any) {
        osagoPresenter.setIsForeigner(isForeigner: false)
        uzbCitizen.active()
        foreignCitizen.inactive()
    }
    
    @IBAction func foreignCitizenClicked(_ sender: Any) {
        osagoPresenter.setIsForeigner(isForeigner: true)
        uzbCitizen.inactive()
        foreignCitizen.active()
    }
    
    func setRegionList(regionList: [Region]) {
        self.regionList.isEnabled = !regionList.isEmpty
        self.regionList.optionArray = regionList.map{ $0.name }
        self.regionList.optionIds = regionList.map{ $0.id }
    }
    
    @IBAction func onNextClick(_ sender: Any) {
        self.osagoPresenter.openOsago2()
    }
    
    func setLoading(isLoading: Bool) {
        
        nextButton.isLoading = isLoading
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
}
