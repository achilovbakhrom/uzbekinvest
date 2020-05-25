//
//  PinflVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class PinflVC: BaseViewImpl {
    lazy var pinflView: PinflView = PinflView.fromNib()
    private lazy var settingsPresenter = self.presenter as? SettingsPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pinflView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pinflView)
        NSLayoutConstraint.activate([
            self.pinflView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pinflView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.pinflView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pinflView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.pinflView.onRemove = { id in
            let ac = UIAlertController(title: "remove_pinfl".localized(), message: "remove_pinfl_msg".localized(), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "yes".localized(), style: .destructive, handler: { _ in
                self.settingsPresenter?.removePinfl(pinfl: id)
            }))
            ac.addAction(UIAlertAction(title: "no".localized(), style: .cancel, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
        self.pinflView.onAdd = {
            self.settingsPresenter?.openAddByPinfl()
        }
        self.pinflView.onBack = {
            self.settingsPresenter?.goBack()
        }
        self.settingsPresenter?.fetchPinflList()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUpdateSignal(_:)), name: Notification.Name("updatePinfl"), object: nil)
    }
    
    func setLoading(isLoading: Bool) {
        self.pinflView.addButton.isLoading = isLoading
    }
    
    @objc
    private func didReceiveUpdateSignal(_ notification:Notification) {
        self.settingsPresenter?.fetchPinflList()
    }
    
    func setPinflList(list: [Pinfl]) {
        pinflView.pinflList = list
    }
    
}
