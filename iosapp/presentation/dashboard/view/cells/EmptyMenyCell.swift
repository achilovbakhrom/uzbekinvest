//
//  EmptyMenyCell.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class EmptyMenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        let width = UIScreen.main.bounds.width * 0.95
        let height = UIScreen.main.bounds.height
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            view.widthAnchor.constraint(equalToConstant: width/2),
            view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: height/3.0),
            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])        
    }
    
}

