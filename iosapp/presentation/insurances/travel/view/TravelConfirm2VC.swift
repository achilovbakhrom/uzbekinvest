//
//  TravelConfirm2VC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/19/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class TravelConfirm2VC: BaseWithLeftCirclesVC, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var touristsListView: UITableView!
    @IBOutlet weak var nextButton: Button!
    
    @IBOutlet weak var titleLabel: UILabel!
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    private var touristsList: [Tourist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
        backButtonClicked = { self.travelPresenter?.goBack() }
        touristsListView.rowHeight = UITableView.automaticDimension
        touristsListView.estimatedRowHeight = 44.0
        touristsListView.showsVerticalScrollIndicator = false
        touristsListView.separatorStyle = .none
        touristsListView.delegate = self
        touristsListView.dataSource = self
        touristsListView.register(TouristList2Cell.self, forCellReuseIdentifier: String(describing: TouristList2Cell.self))
        self.travelPresenter?.initTravelConfirm2VC()
        self.titleLabel.text = "tourist_list".localized()
        self.nextButton.setTitle("checkout".localized(), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.touristsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TouristList2Cell.self)) as! TouristList2Cell
        cell.touristNoLabel.text = "\("tourist_number".localized()) \(indexPath.row + 1)"
        
        cell.onNameChange = { name in
            self.travelPresenter?.setTouristName(at: indexPath.row, name: name)
        }
        cell.onDatePick = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.travelPresenter?.setTouristDob(at: indexPath.row, dob: formatter.string(from: date))
        }
        cell.onPassportChange = { passport in
            self.travelPresenter?.setTouristPassport(at: indexPath.row, passport: passport)
        }
        cell.setData(tourist: touristsList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func setTouristsList(list: [Tourist]) {
        self.touristsList = list
        UIView.transition(with: touristsListView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.touristsListView.reloadData()
        }, completion: nil)
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        
        self.travelPresenter?.applyInsuranceClicked()
    }
    
    func setEnabled(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }
}

class TouristList2Cell: UITableViewCell {
    
    var onDatePick: ((Date) -> Void)? = nil
    var onNameChange: ((String) -> Void)? = nil
    var onPassportChange: ((String) -> Void)? = nil
    
    private lazy var nameTextField: SimpleTextField = {
        let textField = SimpleTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "fio".localized()
        return textField
    }()

    private lazy var datePicker: DatePicker = {
        let datePicker = DatePicker(frame: .zero)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.placeholder = "birthdate".localized()
        return datePicker
    }()
    
    private lazy var passportTextField: SimpleTextField = {
        let textField = SimpleTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "passport_seria".localized()
        return textField
    }()
    
    var touristNoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Bold", size: 14.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let touristNoView = UIView(frame: .zero)
        touristNoView.translatesAutoresizingMaskIntoConstraints = false
        touristNoView.backgroundColor = Colors.primaryGreen.withAlphaComponent(0.3)
        self.contentView.addSubview(touristNoView)
        NSLayoutConstraint.activate([
            touristNoView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            touristNoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            touristNoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            touristNoView.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        
        touristNoView.addSubview(touristNoLabel)
        NSLayoutConstraint.activate([
            touristNoLabel.leadingAnchor.constraint(equalTo: touristNoView.leadingAnchor, constant: 20),
            touristNoLabel.centerYAnchor.constraint(equalTo: touristNoView.centerYAnchor)
        ])
        
        self.contentView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            nameTextField.topAnchor.constraint(equalTo: touristNoView.bottomAnchor, constant: 35),
            nameTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
        ])
        nameTextField.onChange = { self.onNameChange?($0) }
        
        self.contentView.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            datePicker.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 22),
            datePicker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        datePicker.onChange = { self.onDatePick?($0) }
        
        self.contentView.addSubview(passportTextField)
        NSLayoutConstraint.activate([
            passportTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            passportTextField.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 22),
            passportTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        self.passportTextField.onChange = { self.onPassportChange?($0) }
        
        let div = UIView(frame: .zero)
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = .lightGray
        self.contentView.addSubview(div)
        NSLayoutConstraint.activate([
            div.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            div.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            div.topAnchor.constraint(equalTo: self.passportTextField.bottomAnchor, constant: 20),
            div.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setData(tourist: Tourist) {
        self.nameTextField.text = tourist.name
        self.datePicker.text = tourist.dob
        self.passportTextField.text = tourist.passportNumber
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


