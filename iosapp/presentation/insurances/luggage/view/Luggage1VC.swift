//
//  Luggage1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class Luggage1VC: BaseWithLeftCirclesVC {
    
    @IBOutlet weak var days: DDown!
    @IBOutlet weak var nextButton: Button!
    private lazy var luggagePresenter = self.presenter as? LuggagePresenter
    
    private lazy var daysData: ([Int], [String]) = {
        var ids = [Int]()
        var titles = [String]()
        (1...30).forEach {
            ids.append($0)
            var suffix = ""
            if (10...20).contains($0) {
                suffix = "days".localized()
            } else if 1 < $0%10 && $0%10 < 5   {
                suffix = "day_2".localized()
            } else if $0%10 >= 5 || $0%10 == 0 {
                suffix = "days".localized()
            } else {
                suffix = "day".localized()
            }
            titles.append("\($0) \(suffix)")
        }
        return (ids, titles)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
        
        self.days.optionIds = daysData.0
        self.days.optionArray = daysData.1
        self.days.didSelect {
            self.luggagePresenter?.setDay(day: $2, dayString: $0)
        }
        self.backButtonClicked = { self.luggagePresenter?.goBack() }
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.luggagePresenter?.openLuggage2VC()
    }
}
