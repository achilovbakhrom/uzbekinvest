//
//  PinflView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class PinflView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var pinflListView: UITableView!
    
    var onBack: (() -> Void)? = nil
    var onAdd: (() -> Void)? = nil
    var onRemove: ((Int) -> Void)? = nil
    @IBOutlet weak var addButton: Button!
    var pinflList: [Pinfl] = [] {
        didSet {
            UIView.transition(with: self.pinflListView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.pinflListView.reloadData()
            }, completion: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pinflListView.showsVerticalScrollIndicator = false
        pinflListView.register(PinflCell.self, forCellReuseIdentifier: String(describing: PinflCell.self))
        pinflListView.delegate = self
        pinflListView.dataSource = self
        pinflListView.separatorStyle = .none
        pinflListView.rowHeight = 50.0
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        onBack?()
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        onAdd?()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pinflList.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < pinflList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PinflCell.self), for: indexPath) as! PinflCell
            cell.pinflLabel.text = self.pinflList[indexPath.row].pinfl
            cell.onRemove = {
                self.onRemove?(self.pinflList[indexPath.row].id ?? 0)
            }
            cell.selectionStyle = .none            
            return cell
        } else {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

class PinflCell: UITableViewCell {
    
    lazy var pinflLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        return label
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton.init(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Удалить", for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()
    
    var onRemove: (() -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(removeButton)
        NSLayoutConstraint.activate([
            self.removeButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.removeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.removeButton.heightAnchor.constraint(equalToConstant: 30),
            self.removeButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        removeButton.layer.cornerRadius = 15.0
        removeButton.layer.masksToBounds = true
        
        self.contentView.addSubview(pinflLabel)
        NSLayoutConstraint.activate([
            self.pinflLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.pinflLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.pinflLabel.trailingAnchor.constraint(equalTo: self.removeButton.leadingAnchor, constant: -10),
        ])
        self.removeButton.addTarget(self, action: #selector(onRemoveAction(_:)), for: .touchUpInside)
        
        let div = UIView(frame: .zero)
        div.translatesAutoresizingMaskIntoConstraints = true
        div.backgroundColor = .lightGray
        self.contentView.addSubview(div)
        NSLayoutConstraint.activate([
            div.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            div.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            div.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            div.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onRemoveAction(_ sender: Any) {
        self.onRemove?()
    }
    
}
