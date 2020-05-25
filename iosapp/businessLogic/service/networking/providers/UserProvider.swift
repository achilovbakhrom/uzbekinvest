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
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
