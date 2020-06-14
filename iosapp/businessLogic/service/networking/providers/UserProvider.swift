//
//  UserProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum UserProvider {
    case getUserById(id: Int64)
    case updateUser(user: UserRequest)
    case userFiles
    case uploadDocuments(files: [String])
    case deleteDocuments(files: [String])
    case availableDocuments
    case fetchDocumentById(id: Int)
    case fetchUserFiles
    case fetchUserInsurances
    case uploadFile(data: Data, documentId: Int, name: String = "file", mimeType: String = "image/png")
    case fetchMe
    case removeFile(id: Int)
    case fetchOffices
    case fetchOrders
    case addPinfl(pinfl: Pinfl)
    case getPinflList
    case removePinfl(id: Int)
    case fetchNotification
    case news(lang: String)
    case updatePaymentType(orderId: Int, paymentType: String)
    case call(phone: String)
    case createChat
    case createMessage(chatId: String, message: String)
    case fetchChatList(chatId: String)
}

extension UserProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getUserById(let id):
            return "/api/v2/user\(id)"
        case .updateUser:
            return "/api/user"
        case .userFiles:
            return "/api/v2/user/files"
        case .uploadDocuments:
            return "/api/v2/user/files"
        case .deleteDocuments:
            return "/api/v2/user/files"
        case .availableDocuments:
            return "/api/document"
        case .fetchDocumentById(let id):
            return "/api/product/\(id)/documents"
        case .fetchUserFiles:
            return "/api/user/file"
        case .uploadFile:
            return "/api/user/file"
        case .fetchUserInsurances:
            return "/api/user/order"
        case .fetchMe:
            return "/api/user/me"
        case .fetchOffices:
            return "/api/contact"
        case .fetchOrders:
            return "/api/user/order/all"
        case .removeFile(let id):
            return "/api/user/file/\(id)"
        case .addPinfl:
            return "/api/user/pinfl"
        case .removePinfl(let id):
            return "/api/user/pinfl/\(id)"
        case .getPinflList:
            return "/api/user/pinfl"
        case .fetchNotification:
            return "/api/user/notification"
        case .news:
            return "/api/news"
        case .updatePaymentType(let orderId, _):
            return "/api/user/order/\(orderId)/payment"
        case .call:
            return "/api/call"
        case .createChat:
            return "/api/chat"
        case .createMessage:
            return "/api/chat/send"
        case .fetchChatList:            
            return "/api/chat/messages"
        }
    }
    
    var method: Method {
        switch self {
        case .getUserById:
            return .get
        case .updateUser:
            return .put
        case .userFiles:
            return .get
        case .uploadDocuments:
            return .post
        case .deleteDocuments:
            return .delete
        case .availableDocuments:
            return .get
        case .fetchDocumentById:
            return .get
        case .fetchUserFiles:
            return .get
        case .uploadFile:
            return .post
        case .fetchUserInsurances:
            return .get
        case .fetchMe:
            return .get
        case .fetchOffices:
            return .get
        case .fetchOrders:
            return .get
        case .removeFile:
            return .delete
        case .removePinfl:
            return .delete
        case .addPinfl:
            return .post
        case .getPinflList:
            return .get
        case .fetchNotification:
            return .get
        case .news:
            return .get
        case .updatePaymentType:
            return .put
        case .call:
            return .post
        case .createChat:
            return .post
        case .createMessage:
            return .post
        case .fetchChatList:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getUserById:
            return .requestPlain
        case .updateUser(let user):
            return .requestParameters(parameters: user.dictionary!, encoding: JSONEncoding.default)
        case .userFiles:
            return .requestPlain
        case .uploadDocuments(let files):
            return .requestParameters(parameters: ["files": files], encoding: JSONEncoding.default)
        case .deleteDocuments(let files):
            return .requestParameters(parameters: ["files" : files], encoding: JSONEncoding.default)
        case .availableDocuments:
            return .requestPlain
        case .fetchDocumentById:
            return .requestPlain
        case .fetchUserFiles:
            return .requestPlain
        case .uploadFile(let data, let documentId, let name, let mimeType):
            let multipart = MultipartFormData(provider: .data(data), name: "files[0][name]", fileName: name, mimeType: mimeType)
            let docId = MultipartFormData(provider: .data("\(documentId)".data(using: .utf8)!), name: "files[0][document_id]")
            return .uploadMultipart([multipart, docId])
        case .fetchUserInsurances:
            return .requestPlain
        case .fetchMe:
            return .requestPlain
        case .fetchOffices:
            return .requestPlain
        case .fetchOrders:
            return .requestPlain
        case .removeFile:
            return .requestPlain
        case .removePinfl:
            return .requestPlain
        case .getPinflList:
            return .requestPlain
        case .addPinfl(let pinfl):
            return .requestParameters(parameters: pinfl.dictionary!, encoding: JSONEncoding.default)
        case .fetchNotification:
            return .requestPlain
        case .news(let lang):
            return .requestParameters(parameters: ["lang" : lang], encoding: URLEncoding.default)
        case .updatePaymentType(_, let paymentType):
            return .requestParameters(parameters: ["payment_method" : paymentType], encoding: JSONEncoding.default)
        case .call(let phone):
            return .requestParameters(parameters: ["phone" : phone], encoding: JSONEncoding.default)
        case .createChat:
            return .requestPlain
        case .fetchChatList(let chatId):
            var lang = "ru"
            switch translatePosition {
            case 0:
                lang = "ru"
                break
            case 1:
                lang = "uz"
                break
            case 2:
                lang = "oz"
                break
            default:
                lang = "ru"
                break
            }
            return .requestCompositeParameters(bodyParameters: ["chat_id" : chatId], bodyEncoding: JSONEncoding.default, urlParameters: ["page" : 1, "lang": lang])
        case .createMessage(let chatId, let message):
            return .requestParameters(parameters: ["chat_id" : chatId, "message": message], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
