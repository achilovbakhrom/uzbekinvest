//
//  InfoVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 7/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class InfoVC: UIViewController {
    
    var text: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let button = UIButton.init(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 31),
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
            button.widthAnchor.constraint(equalToConstant: 35),
            button.heightAnchor.constraint(equalToConstant: 35)
        ])
        button.setImage(UIImage.init(named: "back-arrow"), for: .normal)
        button.addTarget(self, action: #selector(goBackAction(_:)), for: .touchUpInside)
        
        let titleLabel = UILabel.init(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.init(name: "Roboto-Medium", size: 18)
        titleLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        titleLabel.text = "instruction".localized()
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 31),
            titleLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -31),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let contentLabel = UILabel.init(frame: .zero)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.font = UIFont.init(name: "Roboto-Regular", size: 15)        
        contentLabel.textColor = UIColor.black.withAlphaComponent(0.4)
        contentLabel.text = self.text.htmlToString
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        self.view.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 31),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -31)
        ])
        
    }
    
    
    @objc
    private func goBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
