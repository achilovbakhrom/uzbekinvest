//
//  AddingInstructionVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class AddingInstructionVC: BaseWithLeftCirclesVC {
    
    private lazy var instructionView: AddingInstructionView = AddingInstructionView.fromNib()
    private lazy var addExistingPresenter = self.presenter as? AddingInsurancePresenter
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.instructionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(instructionView)
        NSLayoutConstraint.activate([
            instructionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            instructionView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 20),
            instructionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            instructionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.backButtonClicked = {
            self.addExistingPresenter?.goBack()            
        }
        
        instructionView.onNextClieckd = {
            self.addExistingPresenter?.openAddExistingInsurancePage()
        }
        
        instructionView.onCheckedChanged = { checked in
            self.addExistingPresenter?.setShowAgain(isShowAgain: checked)
        }        
        
        self.addExistingPresenter?.setupInstructionPage()        
    }
    
    func setShowAgainButtonChecked(isChecked: Bool) {
        self.instructionView.checkButton.isSelected = isChecked
    }
    
    
}

