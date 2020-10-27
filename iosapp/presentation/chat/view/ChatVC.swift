//
//  ChatVC.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/9/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import UIKit
import MessengerKit

struct Sender: MSGUser {
    var displayName: String
    var avatar: UIImage?
    var isSender: Bool
}

class ChatVC: MSGMessengerViewController, MSGDataSource {
    
    let tim = Sender(displayName: "Оператор", avatar: nil, isSender: false)
    let steve = Sender(displayName: "Я", avatar: nil, isSender: true)
    
    var presenter: ChatPresenter? = nil
    
    override var style: MSGMessengerStyle {
        var style = MessengerKit.Styles.iMessage
        style.headerHeight = 0
        style.inputPlaceholder = "Введите текст"
        style.alwaysDisplayTails = true
        style.outgoingBubbleColor = Colors.primaryGreen
        style.outgoingTextColor = .white        
        style.incomingBubbleColor = .lightGray
        style.incomingTextColor = .black
        style.backgroundColor = Colors.primaryGreen.withAlphaComponent(0.1)
        style.inputViewBackgroundColor = .white
        return style
    }
    
    lazy var messages: [[MSGMessage]] = {
        return [
//            [
//                MSGMessage(id: 1, body: .text("🐙💦🔫"), user: tim, sentAt: Date()),
//            ],
//            [
//                MSGMessage(id: 2, body: .text("Yeah sure, gimme 5"), user: steve, sentAt: Date()),
//                MSGMessage(id: 3, body: .text("Okay ready when you are"), user: steve, sentAt: Date())
//            ]
        ]
    }()
    
    private lazy var loadingView: LoadingView = LoadingView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        dataSource = self
        self.setTabBarHidden(true)
        self.tintColor = Colors.primaryGreen
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Чат"
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.loadingView.layer.opacity = 0.0
        self.presenter?.createChat()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
        self.setTabBarHidden(false)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func numberOfSections() -> Int {
        return messages.count
    }
    
    func numberOfMessages(in section: Int) -> Int {
        return messages[section].count
    }
    
    func message(for indexPath: IndexPath) -> MSGMessage {
        return messages[indexPath.section][indexPath.item]
    }
    
    func footerTitle(for section: Int) -> String? {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: messages[section][0].sentAt)
//        return ""
    }
    
    func headerTitle(for section: Int) -> String? {
        return messages[section].first?.user.displayName
    }
    
    func setLoading(isLoading: Bool)  {
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
        UIView.animate(withDuration: 0.2) {
            self.loadingView.layer.opacity = isLoading ? 1.0 : 0.0
        }
    }
    
    var lastIndex = 1
    
    func setMessages(messages: [ChatMessage]) {
        messages.forEach { message in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
            var date = Date()
            if let c = message.createdAt {
                date = dateFormatter.date(from: c) ?? Date()
            }
            
            if let _ = message.admin {
                self.messages.append([MSGMessage(id: lastIndex, body: .text(message.message ?? ""), user: tim, sentAt: date)])
            } else {
                self.messages.append([MSGMessage(id: lastIndex, body: .text(message.message ?? ""), user: steve, sentAt: date)])
            }
            self.lastIndex += 1
        }
        UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
    }
    
    override func inputViewPrimaryActionTriggered(inputView: MSGInputView) {
        self.presenter?.createMessage(message: inputView.message)
        self.lastIndex += 1
        self.messages.append([MSGMessage(id: self.lastIndex, body: .text(inputView.message), user: steve, sentAt: Date())])
        UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
    }
    
}


