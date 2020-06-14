//
//  ChatPresenter.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import UIKit

protocol ChatPresenter: BasePresenter {
    func createChat()
    func createMessage(message: String)
    func setChatMessages(messages: [ChatMessage])
    func setLoading(isLoading: Bool)
    func showError(msg: String)
    func setChatId(chatId: String)
}

class ChatPresenterImpl: ChatPresenter {
    
    var interactor: BaseInteractor?
    var router: BaseRouter?
    var chatId: String!
    
    var view: UIViewController?
    
    private lazy var chatView = self.view as? ChatVC
    private lazy var chatInteractor = self.interactor as? ChatInteractor
    
    func createChat() {
        if let chatId = self.chatInteractor?.fetchLocalChatId() {
            self.chatId = chatId
            self.chatInteractor?.fetchMessages(chatId: chatId)
        } else {
            self.chatInteractor?.fetchChatId()
        }
    }
    
    func createMessage(message: String) {
        self.chatInteractor?.createMessage(chatId: self.chatId, message: message)
    }
    
    func setChatMessages(messages: [ChatMessage]) {
        self.chatView?.setMessages(messages: messages)
    }
    
    func setLoading(isLoading: Bool) {
        self.chatView?.setLoading(isLoading: isLoading)
    }
    
    func showError(msg: String) {
        self.chatView?.showErrorMessage(msg: msg)
    }
    
    func setChatId(chatId: String) {
        self.chatId = chatId
    }
    
    
    
    
    
}
