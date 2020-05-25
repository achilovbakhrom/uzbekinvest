//
//  Sport1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/5/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Sport1VC: BaseWithLeftCirclesVC {
        
    @IBOutlet weak var sport: DDown!
    @IBOutlet weak var nextButton: Button!
    
    private lazy var sportsPresenter = self.presenter as? SportsPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        self.backButtonClicked = { self.sportsPresenter?.goBack() }
        sport.isSearchEnable = true
        self.sportsPresenter?.fetchSports()        
        self.sport.didSelect {
            self.sportsPresenter?.setSportId(id: $2, sportString: $0)
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.sportsPresenter?.openSport2VC()
    }
    
    func setSports(ids: [Int], array: [String]) {
        sport.optionIds = ids
        sport.optionArray = array
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    func setLoading(isLoading: Bool) {
        self.nextButton.isLoading = isLoading
    }
    
}
