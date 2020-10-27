//
//  BaseViewImpl.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/21/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class BaseViewImpl: UIViewController, BaseView {
    
    var presenter: BasePresenter? = nil
    private var promocode: String?
    private var messageController: UIAlertController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showLoading() {}
    
    func hideLoading() {}
    
    func showMessage(msg: String, title: String? = "Предуперждение!") {
        self.messageController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        self.messageController.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        self.present(self.messageController, animated: true, completion: nil)
    }
    
    func hideMessage() {
        self.dismiss(animated: true) { self.messageController = nil }
    }
    
    func showNetworkError() {}
    
    func hideNetworkError() {}
        
    
    func showPromocodeDialog() {
        let alertC = UIAlertController.init(title: "", message: "\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let viewC = UIView.init(frame: .zero)
        viewC.translatesAutoresizingMaskIntoConstraints = false
        viewC.backgroundColor = .white
        viewC.layer.cornerRadius = 20
        viewC.layer.masksToBounds = true
        
        alertC.view.addSubview(viewC)
        NSLayoutConstraint.activate([
            viewC.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.7),
            viewC.leadingAnchor.constraint(equalTo: alertC.view.leadingAnchor),
            viewC.trailingAnchor.constraint(equalTo: alertC.view.trailingAnchor),
            viewC.topAnchor.constraint(equalTo: alertC.view.topAnchor),
            viewC.bottomAnchor.constraint(equalTo: alertC.view.bottomAnchor)
        ])
        
        
        let promocodeTitleLabel = UILabel.init()
        promocodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeTitleLabel.text = "promocode".localized()
        promocodeTitleLabel.font = UIFont.init(name: "Roboto-Bold", size: 16)
        promocodeTitleLabel.textColor = .black
        viewC.addSubview(promocodeTitleLabel)
        NSLayoutConstraint.activate([
            promocodeTitleLabel.leadingAnchor.constraint(equalTo: viewC.leadingAnchor, constant: 15),
            promocodeTitleLabel.topAnchor.constraint(equalTo: viewC.topAnchor, constant: 15)
        ])
        
        let promocodeTextField = SimpleTextField.init()
        promocodeTextField.translatesAutoresizingMaskIntoConstraints = false
        promocodeTextField.onChange = {
            self.promocode = $0
        }
        viewC.addSubview(promocodeTextField)
        NSLayoutConstraint.activate([
            promocodeTextField.leadingAnchor.constraint(equalTo: viewC.leadingAnchor, constant: 15),
            promocodeTextField.topAnchor.constraint(equalTo: promocodeTitleLabel.bottomAnchor, constant: 20),
            promocodeTextField.trailingAnchor.constraint(equalTo: viewC.trailingAnchor, constant: -15)
        ])
        
        
        let promocodeDescription = UILabel.init()
        promocodeDescription.translatesAutoresizingMaskIntoConstraints = false
        promocodeDescription.textColor = UIColor.black.withAlphaComponent(0.7)
        promocodeDescription.text = "prmocode_desc".localized()
        promocodeDescription.numberOfLines = 0
        promocodeDescription.font = UIFont.init(name: "Roboto-Regular", size: 14)
        viewC.addSubview(promocodeDescription)
        NSLayoutConstraint.activate([
            promocodeDescription.leadingAnchor.constraint(equalTo: viewC.leadingAnchor, constant: 15),
            promocodeDescription.topAnchor.constraint(equalTo: promocodeTextField.bottomAnchor, constant: 8),
            promocodeDescription.trailingAnchor.constraint(equalTo: viewC.trailingAnchor, constant: -15)
        ])
        
        let promocodeAcceptButton = Button()
        promocodeAcceptButton.translatesAutoresizingMaskIntoConstraints = false
        promocodeAcceptButton.setTitle("add".localized(), for: .normal)
        promocodeAcceptButton.addTarget(self, action: #selector(acceptPromocode(_:)), for: .touchUpInside)
        viewC.addSubview(promocodeAcceptButton)
        NSLayoutConstraint.activate([
            promocodeAcceptButton.leadingAnchor.constraint(equalTo: viewC.leadingAnchor, constant: 15),
            promocodeAcceptButton.trailingAnchor.constraint(equalTo: viewC.trailingAnchor, constant: -15),
            promocodeAcceptButton.topAnchor.constraint(equalTo: promocodeDescription.bottomAnchor, constant: 15),
            promocodeAcceptButton.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        let promocodeCanceButton = Button()
        promocodeCanceButton.translatesAutoresizingMaskIntoConstraints = false
        promocodeCanceButton.makeRedColor()
        promocodeCanceButton.setTitle("cancel".localized(), for: .normal)
        promocodeCanceButton.addTarget(self, action: #selector(cancelPromocode(_:)), for: .touchUpInside)
        
        viewC.addSubview(promocodeCanceButton)
        NSLayoutConstraint.activate([
            promocodeCanceButton.leadingAnchor.constraint(equalTo: viewC.leadingAnchor, constant: 15),
            promocodeCanceButton.trailingAnchor.constraint(equalTo: viewC.trailingAnchor, constant: -15),
            promocodeCanceButton.topAnchor.constraint(equalTo: promocodeAcceptButton.bottomAnchor, constant: 10),
            promocodeCanceButton.heightAnchor.constraint(equalToConstant: 38),
            promocodeCanceButton.bottomAnchor.constraint(equalTo: viewC.bottomAnchor, constant: -15)
        ])
        
        self.present(alertC, animated: true, completion: nil)
    }
    
    @objc
    private func acceptPromocode(_ sender: Any) {
        self.onPromocodeAccept(promocode: self.promocode ?? "")
        self.dismiss(animated: true) {
            self.promocode = ""
        }
    }
    
    @objc
    private func cancelPromocode(_ sender: Any) {
        self.dismiss(animated: true) {
            self.promocode = ""
        }
    }
    
    
    func onPromocodeAccept(promocode: String) {}
    
}
