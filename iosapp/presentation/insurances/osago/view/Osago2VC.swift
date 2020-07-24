//
//  Osago2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/3/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit
import Material

class Osago2VC: BaseWithLeftCirclesVC {
    
    
    @IBOutlet weak var carDropDown: DDown!
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var isInvalidCheckbox: UIButton!
    @IBOutlet weak var isRetiredCheckbox: UIButton!
    @IBOutlet weak var isRetiredLabel: UILabel!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var osagoPresenter: OsagoPresenter = self.presenter as! OsagoPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isInvalidCheckbox.addTarget(self, action: #selector(onInvalidButtonClicked(sender:)), for: .touchUpInside)
        isRetiredCheckbox.addTarget(self, action: #selector(onRetiredButtonClicked(sender:)), for: .touchUpInside)
        invalidLabel.isUserInteractionEnabled = true
        isRetiredLabel.isUserInteractionEnabled = true
        invalidLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onInvaidCheckboxChange(_:))))
        isRetiredLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onRetiredCheckboxChange(_:))))
                
        osagoPresenter.fetchTransportList()
        self.backButtonClicked = {
            self.osagoPresenter.goBack()
        }
        carDropDown.didSelect {
            self.osagoPresenter.setTransportId(transportId: $2, transportName: $0)
        }
        nextButton.isEnabled = false
    }
    
    @objc
    private func onInvalidButtonClicked(sender: Any) {
        self.isInvalidCheckbox.isSelected = !isInvalidCheckbox.isSelected
        self.osagoPresenter.setIsInvalid(isInvalid: isInvalidCheckbox.isSelected)
    }
    
    @objc
    private func onRetiredButtonClicked(sender: UITapGestureRecognizer) {
        self.isRetiredCheckbox.isSelected = !isRetiredCheckbox.isSelected
        self.osagoPresenter.setIsRetired(isRetired: isRetiredCheckbox.isSelected)
    }
    
    @objc
    private func onInvaidCheckboxChange(_ sender: UITapGestureRecognizer) {
        self.isInvalidCheckbox.isSelected = !isInvalidCheckbox.isSelected
        self.osagoPresenter.setIsInvalid(isInvalid: isInvalidCheckbox.isSelected)
    }
    
    @objc
    private func onRetiredCheckboxChange(_ sender: UITapGestureRecognizer) {
        self.isRetiredCheckbox.isSelected = !isRetiredCheckbox.isSelected
        self.osagoPresenter.setIsRetired(isRetired: isRetiredCheckbox.isSelected)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.osagoPresenter.openOsage3()
    }
    
    func setLoading(isLoading: Bool) {
        nextButton.isLoading = isLoading
    }
    
    func setEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
    func setTransportList(list: [Transport]) {
        
        
        
        carDropDown.optionArray = list.map { ti in
            var result: String? = ""
            ti.translates.forEach({ t in
                if t.lang == translateCode {
                    result = t.name
                }
            })
            return result ?? ""
        }
        carDropDown.optionIds = list.map { $0.id }
        if list.count > 0  {
            let t = list[0]
            t.translates.forEach({ t in
                if t.lang == translateCode {
                    carDropDown.text = t.name
                }
            })            
        }
    }
}

