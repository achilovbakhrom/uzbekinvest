//
//  MyInsuranceView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/8/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit

class MyInsuranceView: UIView, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedCategory = 0
    
    var data: [MyInsurance] = [] {
        didSet {
            UIView.transition(with: tableView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.tableView.reloadData() })
        }
    }
    
    var properties: [MyInsuranceProperties] = []
    
    var categories: [Category] = [] {
        didSet {
            UIView.transition(with: collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.collectionView.reloadData() })
        }
    }
    
    var onCategorySelected: ((Category) -> Void)? = nil
    var onInsuranceClicked: ((MyInsurance, MyInsuranceProperties) -> Void)? = nil
    var onAdd: (() -> Void)? = nil
    
    private func setupUI() {
        tableView.register(MyInsuranceCell.self, forCellReuseIdentifier: String(describing: MyInsuranceCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyInsuranceCategoryCell.self, forCellWithReuseIdentifier: String(describing: MyInsuranceCategoryCell.self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyInsuranceCell.self)) as! MyInsuranceCell
        cell.setData(data: data[indexPath.row], isLast: indexPath.row == data.count - 1)
        cell.onItemClick = { item in
            self.onInsuranceClicked?(item, self.properties[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyInsuranceCategoryCell.self), for: indexPath) as! MyInsuranceCategoryCell
        cell.setData(category: self.categories[indexPath.row], isSelected: indexPath.row == selectedCategory, isFirst: indexPath.row == 0)
        cell.onButtonClicked = {
            self.selectedCategory = indexPath.row
            self.onCategorySelected?(self.categories[indexPath.row])
            UIView.transition(with: collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.collectionView.reloadData() })            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cWidth = UIScreen.main.bounds.width/2.5
        return CGSize(width: indexPath.row == 0 ? 31 + cWidth : cWidth, height: 60.0)
    }
    
    @IBAction func onAddClicked(_ sender: Any) {
        onAdd?()
    }
    
    
}
