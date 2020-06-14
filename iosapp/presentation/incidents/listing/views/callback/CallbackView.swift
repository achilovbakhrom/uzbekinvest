//
//  CallbackView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class CallbackView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Bold", size: 18)
        label.textColor = .black
        label.text = "Заказать обратный звонок"
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.text = "Горячая линия: 71 207-60-00"
        return label
    }()
    
    lazy var phoneTextField: PhoneTextField = {
        let textField = PhoneTextField.init(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var button: Button = {
        let button = Button.init(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Заказать", for: .normal)
        return button
    }()
    
    lazy var cancelButton: Button = {
        let button = Button.init(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отмена", for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    var onCallback: (() -> Void)? = nil
    var onCancel: (() -> Void)? = nil
    
    var phone: String = ""
    private func setupUI() {
        self.isUserInteractionEnabled = true
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        self.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 6),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        self.addSubview(phoneTextField)
        NSLayoutConstraint.activate([
            self.phoneTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.phoneTextField.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 30),
            self.phoneTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.phoneTextField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        self.addSubview(button)
        NSLayoutConstraint.activate([
            self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.button.topAnchor.constraint(equalTo: self.phoneTextField.bottomAnchor, constant: 20),
            self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.button.heightAnchor.constraint(equalToConstant: 45.0)
        ])
        self.button.isEnabled = false
        self.button.addTarget(self, action: #selector(callbackAction(_:)), for: .touchUpInside)
        phoneTextField.onChange = {
            self.phone = $0
            self.button.isEnabled = $0.digits.count == 12 && $0.digits.starts(with: "9989")
        }
        
        self.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            self.cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.cancelButton.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 10),
            self.cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 45.0)
        ])
        self.cancelButton.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
    }
    
    @objc
    private func callbackAction(_ sender: Any) {
        self.onCallback?()
    }
    
    @objc
    private func cancelAction(_ sender: Any) {
        self.onCancel?()
    }
}

