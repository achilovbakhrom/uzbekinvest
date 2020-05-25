//
//  ProductProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/23/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum ProductProvider {
    case fetchAllProduct
}

extension ProductProvider: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .fetchAllProduct:
            return "/api/product/active"
        }
    }
    
    var method: Method {
        switch self {
        case .fetchAllProduct:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .fetchAllProduct:
            return .requestPlain        
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
}
