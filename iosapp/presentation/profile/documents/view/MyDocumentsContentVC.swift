//
//  MyDocumentsContentView.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 5/16/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import Agrume
import Kingfisher

class MyDocumentsContentVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var userFiles: [UserFile] = [] {
        didSet {
            UIView.transition(with: self.documentsCollectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.documentsCollectionView.reloadData()
            }, completion: nil)
            
        }
    }
    
    var padding: CGFloat = 10.0
    
    var onRemove: ((Int) -> Void)? = nil
    var onUpload: (() -> Void)? = nil
    
    
    private lazy var documentsCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let width = UIScreen.main.bounds.width/2 - 10
        flow.itemSize = CGSize(width: width, height: width + 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(documentsCollectionView)
        NSLayoutConstraint.activate([
            self.documentsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.documentsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.documentsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.documentsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.documentsCollectionView.register(MyDocsUserCell.self, forCellWithReuseIdentifier: String(describing: MyDocsUserCell.self))
        self.documentsCollectionView.register(AddUserFileCell.self, forCellWithReuseIdentifier: String(describing: AddUserFileCell.self))
        self.documentsCollectionView.delegate = self
        self.documentsCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (userFiles.count + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < userFiles.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyDocsUserCell.self), for: indexPath) as! MyDocsUserCell
            if let url = URL(string: "\(BASE_URL)\(userFiles[indexPath.row].name)") {
                cell.setData(url: url)
            }
            cell.onClick = {
                let agrume = Agrume(url: URL(string: "\(BASE_URL)\(self.userFiles[indexPath.row].name)")!, background: .blurred(.light))                
                agrume.download = { url, completion in
                    KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                        completion(image)
                    })
                }
                agrume.show(from: self)
            }
            cell.onRemove = {
                let actionController = UIAlertController(title: "Удаление", message: "Действительно хотите удалить файл?", preferredStyle: .alert)
                actionController.addAction(UIAlertAction(title: "no".localized(), style: .cancel, handler: nil))
                actionController.addAction(UIAlertAction(title: "yes".localized(), style: .destructive, handler: { _ in
                    self.onRemove?(self.userFiles[indexPath.row].id)
                    self.dismiss(animated: true, completion: nil)
                }))
                
                self.present(actionController, animated: true, completion: nil)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AddUserFileCell.self), for: indexPath) as! AddUserFileCell
            cell.onAdd = {
                self.onUpload?()
            }
            return cell
        }
    }
}

class MyDocsUserCell: UICollectionViewCell {
    
    private lazy var fileImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var onRemove: (() -> Void)? = nil
    var onClick: (() -> Void)? = nil
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 11)
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Удалить", for: .normal)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(removeButton)
        NSLayoutConstraint.activate([
            self.removeButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.removeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.removeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.removeButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        self.removeButton.addTarget(self, action: #selector(onRemoveAction(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(self.fileImageView)
        NSLayoutConstraint.activate([
            self.fileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.fileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.fileImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.fileImageView.bottomAnchor.constraint(equalTo: self.removeButton.topAnchor, constant: -8)
        ])
        self.fileImageView.isUserInteractionEnabled = true
        self.fileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickAction(gesture:))))
    }
    
    @objc
    private func onClickAction(gesture: UITapGestureRecognizer) {
        self.onClick?()
    }
    
    @objc
    private func onRemoveAction(_ sender: Any) {
        self.onRemove?()
    }
    
    func setData(url: URL) {
        fileImageView.kf.setImage(with: url, placeholder: UIImage(named: "files-dummy"), options: [
            .transition(.fade(1)),
            .cacheOriginalImage]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AddUserFileCell: UICollectionViewCell {
    
    var onAdd: (() -> Void)? = nil
    
    private lazy var addButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 24)
        button.setTitleColor(Colors.primaryGreen, for: .normal)
        button.setTitle("+", for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = Colors.primaryGreen.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            self.addButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.addButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.addButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            self.addButton.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
        ])
        self.addButton.layer.cornerRadius = self.contentView.bounds.width/4.0
        self.addButton.layer.masksToBounds = true
        self.addButton.addTarget(self, action: #selector(onAddAction(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onAddAction(_ sender: Any) {
        self.onAdd?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
