//
//  IncidentFilesView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/28/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import SwipeCellKit

class IncidentFilesView: UIView, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    @IBOutlet weak var filesTableView: UITableView!
    @IBOutlet weak var nextButton: Button!
    
    var files = [String]()
    var onAddClicked: (() -> Void)? = nil
    var onDelete: ((Int) -> Void)? = nil
    var onNext: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filesTableView.delegate = self
        filesTableView.dataSource = self
        filesTableView.showsVerticalScrollIndicator = false
        filesTableView.showsHorizontalScrollIndicator = false
        filesTableView.register(IncidentFilesCell.self, forCellReuseIdentifier: String(describing: IncidentFilesCell.self))
        filesTableView.rowHeight = UITableView.automaticDimension
        filesTableView.estimatedRowHeight = 44.0
        filesTableView.register(AddFilesFooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: AddFilesFooterView.self))
        filesTableView.sectionFooterHeight = 50.0
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.onNext?()        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IncidentFilesCell.self)) as! IncidentFilesCell
        cell.setData(fileName: files[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "delete".localized()) { action, indexPath in
            self.files.remove(at: indexPath.row)
            UIView.transition(with: self.filesTableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.filesTableView.reloadData()
            }, completion: { _ in
                self.onDelete?(indexPath.row)
            })
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: AddFilesFooterView.self)) as! AddFilesFooterView
        footer.onAddClicked = onAddClicked
        return footer
    }
    
}

class IncidentFilesCell: SwipeTableViewCell {
    
    private lazy var fileTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
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
        let imageView = UIImageView(image: UIImage(named: "files-dummy"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 13),
            imageView.widthAnchor.constraint(equalToConstant: 41),
            imageView.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        self.contentView.addSubview(self.fileTitle)
        NSLayoutConstraint.activate([
            fileTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            fileTitle.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            fileTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
        ])
        
        let div = UIView(frame: .zero)
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.contentView.addSubview(div)
        NSLayoutConstraint.activate([
            div.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            div.topAnchor.constraint(equalTo: self.fileTitle.bottomAnchor, constant: 15),
            div.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31),
            div.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setData(fileName: String) {
        self.fileTitle.text = fileName
    }
    
}

class AddFilesFooterView: UITableViewHeaderFooterView {
    
    var onAddClicked: (() -> Void)? = nil
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = .white
        let button = UploadButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("upload".localized(), for: .normal)
        self.contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 31),
            button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(onAddButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func onAddButtonClicked() {
        onAddClicked?()
    }
    
    
}
