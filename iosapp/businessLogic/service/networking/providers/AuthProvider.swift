//
//  AuthProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//
import Moya

public enum AuthProvider: TargetType {
        
    case registerPhone(phone: String)
    case registerUser(user: User)
    case sendCodeToPhone(phone: String)
    case login(auth: Auth)
    case checkPhoneNumber(phone: String)
    
    public var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    public var path: String {
        switch self {
        case .registerPhone:
            return "/api/v2/phone"
        case .registerUser:
            return "/api/user"
        case .sendCodeToPhone:
            return "/api/code"
        case .login:
            return "/api/login"
        case .checkPhoneNumber:
            return "/api/check"
        }
    }
    
    public var method: Method {
        return .post
    }
    
    public var sampleData: Data {
      return Data()
    }
    
    public var task: Task {
        switch self {
        case .checkPhoneNumber(let phone):
            return .requestParameters(parameters: ["phone" : phone], encoding: JSONEncoding.default)
        case .registerPhone(let phone):
            return .requestParameters(parameters: ["phone" : phone], encoding: JSONEncoding.default)
        case .registerUser(let user):
            return .requestParameters(parameters: user.dictionary ?? [:], encoding: JSONEncoding.default)
        case .sendCodeToPhone(let phone):
            return .requestParameters(parameters: ["phone" : phone], encoding: JSONEncoding.default)
        case .login(let auth):
            return .requestParameters(parameters: auth.dictionary ?? [:], encoding: JSONEncoding.default)
        }
        
    }
    
    public var headers: [String: String]? {
      return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
      return .successCodes
    }
}
