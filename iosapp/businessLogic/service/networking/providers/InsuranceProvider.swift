//
//  InsuranceProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum InsuranceProvider: TargetType {
    
    case products
    case calculate(calcInsurance: InsuranceCalculate)
    case getInsuraceList(page: Int)
    case createInsurance(insurance: Insurance)
    case cancelInsurance(id: Int64)
    case changePayment(id: Int64)
    case requiredDocuments
    
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .calculate:
            return "/api/insurance/calculate"
        case .products:
            return "/api/products"
        case .createInsurance:
            return "/api/v2/insurance"
        case .getInsuraceList:
            return "/api/v2/insurance"
        case .cancelInsurance(let id):
            return "/api/v1/insurance/\(id)"
        case .changePayment(let id):
            return "/api/v1/insurance/\(id)/change-payment"
        case .requiredDocuments:
            return "/api/v2/insurance/documents"
        }
    }
    
    var method: Method {
        switch self {
        case .calculate:
            return .post
        case .products:
            return .get
        case .createInsurance:
            return .post
        case .getInsuraceList:
            return .get
        case .cancelInsurance:
            return .post
        case .changePayment:
            return .put
        case .requiredDocuments:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .calculate(let co):
            return .requestParameters(parameters: co.dictionary!, encoding: JSONEncoding.default)
        case .products:
            return .requestPlain
        case .createInsurance(let insurance):
            return .requestParameters(parameters: insurance.dictionary!, encoding: JSONEncoding.default)
        case .getInsuraceList:
            return .requestPlain
        case .cancelInsurance:
            return .requestPlain
        case .changePayment:
            return .requestPlain
        case .requiredDocuments:
            return .requestPlain

        }
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
