//
//  Travel1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import TagListView

class Travel1VC: BaseWithLeftCirclesVC, TagListViewDelegate {
    
    @IBOutlet weak var countryListDropDown: DDown!
    @IBOutlet weak var nextButton: Button!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    private var countryList = [Country]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.travelPresenter?.goBack() }
        tagListView.textFont =  UIFont.init(name: "Roboto-Regular", size: 15)!
        tagListView.delegate = self
        self.countryListDropDown.isEnabled = false
        self.countryListDropDown.isSearchEnable = true
        self.countryListDropDown.didSelect { (name, _, id) in
            let list = self.countryList.filter { return ($0.id ?? 0) == id }
            if !list.isEmpty {
                let country = list[0]
                if !(self.travelPresenter?.checkCountry(id: country.id ?? 0) ?? false) {
                    self.tagListView.addTag(name)
                    self.countryListDropDown.optionIds = self.countryList.map({ $0.id ?? 0 })
                    self.countryListDropDown.optionArray = self.countryList.map({ c in
                        var result: String? = ""
                        c.translates?.forEach({ t in
                            if t?.lang == translateCode {
                                result = t?.name
                            }
                        })
                        return result ?? ""
                    })
                    self.travelPresenter?.addCountry(country: country)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.countryListDropDown.text = nil }
        }
        
        
        self.travelPresenter?.fetchCountryList()
        self.nextButton.setTitle("next".localized(), for: .normal)
        
        self.titleLabel.text = "travel1_title".localized()
        self.countryListDropDown.placeholder = "travel1_country".localized()
        self.nextButton.isEnabled = false
        
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        var counter = 0
        var found = false
        
        self.countryList.map { c -> String in
                var result: String? = ""
                c.translates?.forEach({ t in
                    if t?.lang == translateCode {
                        result = t?.name
                    }
                })
                return result ?? ""
            }.forEach { name in
                if !found {
                    if name == title {
                        found = true
                    } else {
                        counter += 1
                    }
                }
        }
        self.travelPresenter?.removeCountry(country: self.countryList[counter])
        self.tagListView.removeTag(title)
        self.countryListDropDown.text = ""
    }
    
    func setCountryList(countryList: [Country]) {
        self.countryList = countryList
        self.countryListDropDown.isEnabled = !countryList.isEmpty
        self.countryListDropDown.optionIds = self.countryList.map({ $0.id ?? 0 })
        self.countryListDropDown.optionArray = self.countryList.map({
            var result: String? = ""
            $0.translates?.forEach({ t in
                if t?.lang == translateCode {
                    result = t?.name
                }
            })
            return result ?? ""
        })
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    func setLoading(isLoading: Bool) {
//        self.nextButton.isLoading = isLoading
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.openTravel2VC()
    }
}
