//
//  Transport.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/20/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum TransportProvider {
    case getAllTransports
    case createTransport(transport: Transport)
}

extension TransportProvider: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getAllTransports:
            return "api/transport"
        case .createTransport:
            return "api/transport"
        }
    }
    
    var method: Method {
        switch self {
        case .getAllTransports:
            return .get
        case .createTransport:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllTransports:
            return .requestPlain
        case .createTransport(let transport):
            return .requestParameters(parameters: transport.dictionary ?? [:], encoding: JSONEncoding.default)
        }        
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
}


