//
//  TouristList1VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class TouristList1VC: BaseWithLeftCirclesVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var touristListView: UITableView!
    @IBOutlet weak var nextButton: Button!
    @IBOutlet weak var touristCountLabel: UILabel!
    
    private var members: [Member] = []
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touristListView.showsVerticalScrollIndicator = false
        touristListView.register(TouristList1Cell.self, forCellReuseIdentifier: String(describing: TouristList1Cell.self))
        touristListView.register(TouristListFooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: TouristListFooterView.self))
        touristListView.rowHeight = UITableView.automaticDimension
        touristListView.estimatedRowHeight = 44.0
        touristListView.sectionFooterHeight = 55.0
        touristListView.separatorStyle = .none
        touristListView.delegate = self
        touristListView.dataSource = self
        backButtonClicked = { self.travelPresenter?.goBack() }
        nextButton.isEnabled = false
        travelPresenter?.initTouristsList1VC()
        self.nextButton.setTitle("next".localized(), for: .normal)
        self.touristCountLabel.text = "tourist_list".localized()
    }
    
    func setMembers(members: [Member]) {
        self.members = members
        UIView.transition(with: touristListView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.touristListView.reloadData()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TouristList1Cell.self), for: indexPath) as!  TouristList1Cell
        cell.onDatePick = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.travelPresenter?.setDob(at: indexPath.row, dob: formatter.string(from: date))
        }
        cell.onRemove = {
            self.travelPresenter?.remove(memberAt: indexPath.row)
        }
        cell.selectionStyle = .none
        cell.titleLabel.text = "\("tourist_number".localized()) \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TouristListFooterView.self)) as! TouristListFooterView
        footerView.onAdd = { self.travelPresenter?.addMember() }
        footerView.contentView.backgroundColor = .white
        return footerView
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.travelPresenter?.openTravelConfirm1VC()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
}

class TouristListFooterView: UITableViewHeaderFooterView {
    
    var addButton: AddButton = {
        let button = AddButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("add".localized(), for: .normal)
        return button
    }()
    
    var onAdd: (() -> Void)? = nil
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            self.addButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31.0),
            self.addButton.heightAnchor.constraint(equalToConstant: 40.0),
            self.addButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.addButton.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
        self.addButton.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
    }
    
    @objc
    private func addAction(_ sender: Any) {
        self.onAdd?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class TouristList1Cell: UITableViewCell {
    
    var onRemove: (() -> Void)? = nil
    
    var onDatePick: ((Date) -> Void)? = nil
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.red.withAlphaComponent(0.7).cgColor
        button.setTitleColor(UIColor.red.withAlphaComponent(0.7), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Roboto-Regular", size: 13)
        button.layer.borderWidth = 1.0
        button.setTitle("delete".localized(), for: .normal)
        return button
    }()
    
    private lazy var datePicker: DatePicker = {
        let datePicker = DatePicker(frame: .zero)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.placeholder = "birthdate".localized()
        return datePicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -20),
        ])
        
        self.contentView.addSubview(removeButton)
        NSLayoutConstraint.activate([
            removeButton.leadingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 35),
            removeButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            removeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            removeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        removeButton.layer.cornerRadius = 15.0
        removeButton.layer.masksToBounds = true
        removeButton.addTarget(self, action: #selector(onRemoveAction(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            datePicker.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 14),
            datePicker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            datePicker.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
        
        datePicker.onChange = { self.onDatePick?($0) }
    }
    
    @objc
    private func onRemoveAction(_ sender: Any) {
        onRemove?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
