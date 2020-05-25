//
//  MyInsuranceCategoryCell.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyInsuranceCategoryCell: UICollectionViewCell {
    
    private lazy var button: OrangeButton = {
        let button = OrangeButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    var onButtonClicked: (() -> Void)? = nil
    
    private var leadingConstraint: NSLayoutConstraint!
    
    private func setup() {
        self.contentView.addSubview(button)
        leadingConstraint = self.button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0)
        NSLayoutConstraint.activate([
            leadingConstraint,
            self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
        ])
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
    }
    
    
    
    @objc
    private func onClick(_ sender: Any) {
        self.onButtonClicked?()
    }
    
    func setData(category: Category, isSelected: Bool, isFirst: Bool) {
        self.button.setTitle(category.translates?[translatePosition]?.name, for: .normal)
        self.button.isChecked = isSelected
        self.leadingConstraint.constant = isFirst ? 31 : 0        
    }
    
    
    
}
