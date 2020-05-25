//
//  UploadButton.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

class UploadButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.init(red: 77.0/255.0, green: 207.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        setTitleColor(.white, for: .normal)
        setImage(UIImage(named: "upload-arrow"), for: .normal)
        
        if UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
            semanticContentAttribute = .forceRightToLeft            
        }
        else {
            semanticContentAttribute = .forceLeftToRight
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2
        self.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 14.0, bottom: 8.0, right: 14.0)
    }
}

class AddButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.init(red: 77.0/255.0, green: 207.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        setTitleColor(.white, for: .normal)
        setImage(UIImage(named: "add-outlined"), for: .normal)
        
        if UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
            semanticContentAttribute = .forceRightToLeft
        }
        else {
            semanticContentAttribute = .forceLeftToRight
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2
        self.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 14.0, bottom: 8.0, right: 14.0)
    }
}
