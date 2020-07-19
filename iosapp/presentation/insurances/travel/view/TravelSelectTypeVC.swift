//
//  TravelSelectTypeVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class TravelSelectTypeVC: BaseWithLeftCirclesVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: SimpleTextField!
    @IBOutlet weak var typeTableView: UITableView!
    
    private lazy var travelPresenter = self.presenter as? TravelPresenter
    
    var group: [TravelTypeGroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonClicked = { self.travelPresenter?.goBack() }
        typeTableView.showsVerticalScrollIndicator = false
        typeTableView.delegate = self
        typeTableView.dataSource = self
        typeTableView.rowHeight = 40.0
        typeTableView.sectionHeaderHeight = 44.0
        typeTableView.register(TravelTypeCell.self, forCellReuseIdentifier: String(describing: TravelTypeCell.self))
        typeTableView.register(TravelTypeCellHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: TravelTypeCellHeader.self))
        self.backButtonClicked = { self.travelPresenter?.goBack() }
        travelPresenter?.fetchTypes()
        self.searchTextField.text = "search_field".localized()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group[section].types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TravelTypeCell.self), for: indexPath) as! TravelTypeCell
        cell.titleLabel.text = group[indexPath.section].types[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.travelPresenter?.setClassOfPurpose(clazz: group[indexPath.section].group)
        self.travelPresenter?.openTravel5VC()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TravelTypeCellHeader.self)) as! TravelTypeCellHeader
        view.titleLabel.text = "\("travel_gorup".localized()) \(group[section].group)"
        return view
    }
    
    func setTravelGroup(group: [TravelTypeGroup]) {
        self.group = group
        UIView.transition(with: typeTableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.typeTableView.reloadData()
        }, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.group.count
    }
    
}

class TravelTypeCellHeader: UITableViewHeaderFooterView {
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Medium", size: 18)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        self.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TravelTypeCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        let div = UIView(frame: .zero)
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.contentView.addSubview(div)
        self.contentView.addSubview(div)
        NSLayoutConstraint.activate([
            div.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            div.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            div.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            div.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct TravelTypeGroup {
    var group: String
    var types: [TravelType]
}

struct TravelType {
    var id: Int
    var name: String
}
