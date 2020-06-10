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
    
    let steve = Sender(displayName: "Steve", avatar: nil, isSender: true)
    
    let tim = Sender(displayName: "Tim", avatar: nil, isSender: false)
    
    
    lazy var messages: [[MSGMessage]] = {
        return [
            [
                MSGMessage(id: 1, body: .emoji("🐙💦🔫"), user: tim, sentAt: Date()),
            ],
            [
                MSGMessage(id: 2, body: .text("Yeah sure, gimme 5"), user: steve, sentAt: Date()),
                MSGMessage(id: 3, body: .text("Okay ready when you are"), user: steve, sentAt: Date())
            ]
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
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
        return "Just now"
    }
    
    func headerTitle(for section: Int) -> String? {
        return messages[section].first?.user.displayName
    }
}


