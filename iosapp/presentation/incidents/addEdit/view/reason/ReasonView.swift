//
//  ReasonView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/6/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class ReasonView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var onBack: (() -> Void)? = nil
    var onNext: (() -> Void)? = nil
    var metaDataList: IncidentMetaItem!
    var onType: ((String) -> Void)? = nil
    var onDate: ((String) -> Void)? = nil
    var onTime: ((String) -> Void)? = nil
    
    @IBOutlet weak var datePicker: DatePicker!
    @IBOutlet weak var timePicker: TimePicker!
    @IBOutlet weak var reasonTableViewe: UITableView!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var onNextButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reasonTableViewe.delegate = self
        self.reasonTableViewe.dataSource = self
        self.reasonTableViewe.rowHeight = 60.0
        self.reasonTableViewe.register(IncidentMetaDataCell.self, forCellReuseIdentifier: String(describing: IncidentMetaDataCell.self))
        
        self.datePicker.onChange = {
            let formatter = DateFormatter.init()
            formatter.dateFormat = "dd.MM.yyyy"
            self.onDate?(formatter.string(from: $0))
        }
        
        self.timePicker.onChange = {
            let formatter = DateFormatter.init()
            formatter.dateFormat = "HH:mm"
            self.onTime?(formatter.string(from: $0))
        }
        self.onNextButton.isEnabled = false
    }
    
    @IBAction func backActtion(_ sender: Any) {
        self.onBack?()
    }
    
    @IBAction func onNextAction(_ sender: Any) {
        self.onNext?()
    }
    
    func setIncidentMetaData(list: IncidentMetaItem) {
        self.metaDataList = list
        self.reasonLabel.isHidden = !list.types.isEmpty
        self.onNextButton.isHidden = !list.types.isEmpty
        UIView.transition(with: reasonTableViewe, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.reasonTableViewe.reloadData()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metaDataList == nil ? 0 : metaDataList.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IncidentMetaDataCell.self)) as! IncidentMetaDataCell
        cell.titleLabel.text = metaDataList.types[indexPath.row].translates[translatePosition].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onType?(metaDataList.types[indexPath.row].name)
    }
}

class IncidentMetaDataCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 6.0
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 17)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        self.containerView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
        ])
        
        
    }
    
}
