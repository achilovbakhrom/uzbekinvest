//
//  AuthPlugin.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Moya
import Result

protocol AuthorizedTargetType: TargetType {
  var needsAuth: Bool { get }
}

struct AuthPlugin: PluginType {
  let tokenClosure: () -> String?

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    guard
      let token = tokenClosure()
    else {
      return request
    }
    
    var request = request
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    return request
  }
  
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if let r  = response.response, let t = r.allHeaderFields["Authorization"] as? String {
                UserDefaults.standard.set(t, forKey: "token")
            }
            break
        case .failure:
            break
        }
        
    }
}

