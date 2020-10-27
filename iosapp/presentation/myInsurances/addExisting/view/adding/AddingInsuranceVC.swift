//
//  AddingInsuranceVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class AddingInsuranceVC: BaseWithLeftCirclesVC {
    
    private lazy var instructionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 13)
        button.setTitle("instruction".localized(), for: .normal)
        button.setTitleColor(Colors.primaryGreen, for: .normal)
        return button
    }()
    
    private lazy var addingView: AddingView = AddingView.fromNib()
    
    private lazy var addingPreseinter = self.presenter as? AddingInsurancePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupUI()
    }
    
    private func setupUI() {
        self.instructionButton.addTarget(self, action: #selector(onInstructionButtonClicked), for: .touchUpInside)
        self.view.addSubview(instructionButton)
        NSLayoutConstraint.activate([
            self.instructionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -31),
            self.instructionButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor)
        ])
                
        addingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addingView)
        NSLayoutConstraint.activate([
            self.addingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.addingView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 20),
            self.addingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.addingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        addingView.pinFlNumber.onChange = {
            self.addingPreseinter?.setPinfl(pinfl: $0)
        }
        addingView.onAdd = {
            self.addingPreseinter?.addByPinFl()
        }
        self.backButtonClicked = {
            self.addingPreseinter?.goBack()
        }
        self.addingView.addButton.isEnabled = false

    }
    
    @objc
    private func onInstructionButtonClicked() {
        self.addingPreseinter?.openInstructionsPage()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.addingView.addButton.isEnabled = isEnabled
    }
    
    func setLoading(isLoading: Bool) {
        self.addingView.addButton.isLoading = isLoading
    }
    
}

