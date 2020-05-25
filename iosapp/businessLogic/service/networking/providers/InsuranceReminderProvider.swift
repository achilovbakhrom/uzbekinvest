//
//  InsuranceReminderProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya

enum InsuranceReminderProvider {
    case insuranceReminder(insuranceReminder: InsuranceReminder)
}

extension InsuranceReminderProvider: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        return "/api/v2/insurance-reminder"
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .insuranceReminder(let insuranceReminder):
            return .requestParameters(parameters: insuranceReminder.dictionary!, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
