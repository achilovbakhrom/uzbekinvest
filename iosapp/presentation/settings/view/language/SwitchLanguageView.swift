//
//  SwitchLanguageView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/24/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class SwitchLanguageView: UIView {
    
    private var firstTime = true
    
    private lazy var ruButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Русский", for: .normal)
        return button
    }()
    
    private lazy var uzButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("O'zbekcha", for: .normal)
        return button
    }()
    
    private lazy var uzCyrlButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Узбекча", for: .normal)
        return button
    }()
    
    var onRussian: (() -> Void)? = nil
    var onUzbek: (() -> Void)? = nil
    var onUzbekCyrl: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupLanguage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
        self.setupLanguage()
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.addSubview(ruButton)
        self.ruButton.addTarget(self, action: #selector(onRussianAction(_:)), for: .touchUpInside)
        self.addSubview(uzButton)
        self.uzButton.addTarget(self, action: #selector(onUzbekAction(_:)), for: .touchUpInside)
        self.addSubview(uzCyrlButton)
        self.uzCyrlButton.addTarget(self, action: #selector(onUzbekCyrlAction(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onRussianAction(_ sender: Any) {
        onRussian?()
    }
    
    @objc
    private func onUzbekAction(_ sender: Any) {
        onUzbek?()
    }
    
    @objc
    private func onUzbekCyrlAction(_ sender: Any) {
        onUzbekCyrl?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstTime {
            NSLayoutConstraint.activate([
                ruButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                ruButton.topAnchor.constraint(equalTo: topAnchor),
                ruButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                ruButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            NSLayoutConstraint.activate([
                uzButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                uzButton.topAnchor.constraint(equalTo: ruButton.bottomAnchor),
                uzButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                uzButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            NSLayoutConstraint.activate([
                uzCyrlButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                uzCyrlButton.topAnchor.constraint(equalTo: uzButton.bottomAnchor),
                uzCyrlButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                uzCyrlButton.heightAnchor.constraint(equalToConstant: 40),
                uzCyrlButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            firstTime = false
        }
    }
    
    private func setupLanguage() {
        switch translatePosition {
        case 0:
            ruButton.backgroundColor = Colors.primaryGreen
            ruButton.setTitleColor(.white, for: .normal)
            uzButton.backgroundColor = .white
            uzButton.setTitleColor(Colors.primaryGreen, for: .normal)
            uzCyrlButton.backgroundColor = .white
            uzCyrlButton.setTitleColor(Colors.primaryGreen, for: .normal)
            break
        case 1:
            ruButton.backgroundColor = .white
            ruButton.setTitleColor(Colors.primaryGreen, for: .normal)
            uzButton.backgroundColor = Colors.primaryGreen
            uzButton.setTitleColor(.white, for: .normal)
            uzCyrlButton.backgroundColor = .white
            uzCyrlButton.setTitleColor(Colors.primaryGreen, for: .normal)
            break
        case 2:
            ruButton.backgroundColor = .white
            ruButton.setTitleColor(Colors.primaryGreen, for: .normal)
            uzButton.backgroundColor = .white
            uzButton.setTitleColor(Colors.primaryGreen, for: .normal)
            uzCyrlButton.backgroundColor = Colors.primaryGreen
            uzCyrlButton.setTitleColor(.white, for: .normal)
            break
        default:
            ruButton.backgroundColor = Colors.primaryGreen
            ruButton.setTitleColor(.white, for: .normal)
            uzButton.backgroundColor = .white
            uzButton.setTitleColor(Colors.primaryGreen, for: .normal)
            uzCyrlButton.backgroundColor = .white
            uzCyrlButton.setTitleColor(Colors.primaryGreen, for: .normal)
            break
        }
    }
}
