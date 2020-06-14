//
//  AboutUsVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/13/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class AboutUsVC: BaseViewImpl {
    let aboutUsView: AboutUsView = AboutUsView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(aboutUsView)
        self.aboutUsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.aboutUsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.aboutUsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.aboutUsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.aboutUsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.aboutUsView.onBack = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
