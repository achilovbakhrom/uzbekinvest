//
//  RegionsProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum RegionsProvider {
    case getAllRegions
    case getAllBranches
    case regions
}

extension RegionsProvider: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getAllRegions:
            return "/api/state"
        case .regions:
            return "/api/region"
        case .getAllBranches:
            return "/api/v2/region/branches"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
