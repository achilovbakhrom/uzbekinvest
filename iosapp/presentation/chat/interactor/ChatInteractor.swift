//
//  ChatInteractor.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 6/11/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol ChatInteractor: BaseInteractor {
    
    init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter)
    
    func fetchChatId()
    func fetchLocalChatId() -> String?
    func fetchMessages(chatId: String)
    func createMessage(chatId: String, message: String)
    
}


class ChatInteractorImpl: ChatInteractor {
    
    var serviceFactory: ServiceFactoryProtocol
    var presenter: BasePresenter?
    
    private lazy var chatPresenter = self.presenter as? ChatPresenter
    
    required init(serviceFactory: ServiceFactoryProtocol, presenter: BasePresenter) {
        self.presenter = presenter
        self.serviceFactory = serviceFactory
    }
    
    func fetchChatId() {
        self.chatPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .user
            .request(.createChat) { [unowned self] result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(Response<Chat>.self, from: response.data)
                        let chatId = r.data?.chat_id ?? ""
                        self.serviceFactory.storage.save(key: "chat_id", value: chatId)
                        self.chatPresenter?.setChatId(chatId: chatId)
                        self.fetchMessages(chatId: chatId)
                    } catch (let error) {
                        self.chatPresenter?.setLoading(isLoading: false)
                        self.chatPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error)
                    }
                    break
                case .failure(let error):
                    self.chatPresenter?.setLoading(isLoading: false)
                    self.chatPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error)
                    break
                }
        }
    }
    
    func fetchLocalChatId() -> String? {
        return self.serviceFactory.storage.fetch(key: "chat_id", type: String.self)
    }
    
    func fetchMessages(chatId: String) {
        self.chatPresenter?.setLoading(isLoading: true)
        self
            .serviceFactory
            .networkManager
            .user
            .request(.fetchChatList(chatId: chatId)) { [unowned self] result in
                switch result {
                case .success(let response):
                    self.chatPresenter?.setLoading(isLoading: false)
                    do {
                        let decoder = JSONDecoder.init()
                        let r = try decoder.decode(ArrayResponse<ChatMessage>.self, from: response.data)
                        self.chatPresenter?.setChatMessages(messages: r.data?.reversed() ?? [])
                    } catch (let error) {
                        self.chatPresenter?.showError(msg: error.localizedDescription)
                        debugPrint(error)
                    }
                    break
                case .failure(let error):
                    self.chatPresenter?.setLoading(isLoading: false)
                    self.chatPresenter?.showError(msg: error.localizedDescription)
                    debugPrint(error)
                    break
                }
        }
    }
    
    func createMessage(chatId: String, message: String) {
        self
            .serviceFactory
            .networkManager
            .user
            .request(.createMessage(chatId: chatId, message: message)) { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    debugPrint(error)
                    self.chatPresenter?.showError(msg: error.localizedDescription)
                    break
                }
        }
    }
    
    
    
}
