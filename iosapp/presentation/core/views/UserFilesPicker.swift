//
//  UserFilesPicker.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 4/1/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import Kingfisher

let cellPadding: CGFloat = 5.0;
let cellSize = UIScreen.main.bounds.width/3 - cellPadding


class UserFilesCell: UICollectionViewCell {
    
    var onCellClicked: ((UserFile) -> Void)? = nil
    
    var userFile: UserFile!
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCellClick(_:))))
    }
    
    func setImageUrl(userFile: UserFile) {
        self.userFile = userFile
        let url = URL(string: "\(BASE_URL)\(userFile.name)")
//        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
//            |> RoundCornerImageProcessor(cornerRadius: 20)
        self.imageView.kf.indicatorType = .activity
        self
            .imageView
            .kf
            .setImage(
                with: url,
                placeholder: UIImage(named: "thumbnail"),
                options: [
//                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]){
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
    }
    
    @objc
    private func onCellClick(_ sender: Any) {
        onCellClicked?(userFile)
    }
}


class UserFilesPicker: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var files = [UserFile]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var onFileSelected: ((UserFile) -> Void)? = nil
    
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = cellPadding
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UserFilesCell.self, forCellWithReuseIdentifier: String(describing: UserFilesCell.self))
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "back-arrow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var loadingView: LoadingView = {
        let view: LoadingView = LoadingView.fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.view.backgroundColor = .white
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
                
        self.view.addSubview(self.loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.addSubview(backButton)
        NSLayoutConstraint.activate([
            self.backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 31),
            self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.backButton.widthAnchor.constraint(equalToConstant: 40),
            self.backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        self.backButton.layer.cornerRadius = 20
        self.backButton.layer.masksToBounds = true
        self.backButton.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        
    }
    @objc
    private func backClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserFilesCell.self), for: indexPath) as! UserFilesCell
        let u = self.files[indexPath.row]
        cell.setImageUrl(userFile: u)
        cell.onCellClicked = { userFile in
            self.onFileSelected?(userFile)
            self.navigationController?.popViewController(animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func setLoading(isLoading: Bool) {
        let opacity: Float = isLoading ? 1.0 : 0.0
        isLoading ? self.loadingView.startAnimating() : self.loadingView.stopAnimating()
        UIView.animate(withDuration: 0.2) { self.loadingView.layer.opacity = opacity }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
    }
    
}
