//
//  MyMoyaProvider.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 7/20/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import Moya
import Alamofire



class MyMoyaProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    @discardableResult
    override func request(_ target: Target,
                      callbackQueue: DispatchQueue? = .none,
                      progress: ProgressBlock? = .none,
                      completion: @escaping Completion) -> Cancellable {
        return super.request(target, callbackQueue: callbackQueue, progress: progress, completion: { result in
            switch result {
            case let .success(moyaResponse):
                if (moyaResponse.statusCode == 401) {
                    if moyaResponse.response?.allHeaderFields.index(forKey: "Authorization") != nil {
                        let token = (moyaResponse.response?.allHeaderFields["Authorization"] as? String)?.split(separator: " ")[1] ?? ""
                        UserDefaults.standard.set(token, forKey: "token")
                        let _ = self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
                            completion(result)
                        }
                    } else {
                        completion(result)
                    }
                } else {
                    completion(result)
                }
                break
            case let .failure(error):
                completion(result)
                debugPrint(error)
                break
            }
        })
    }
    
    
//    @discardableResult
//    override func request(_ target: Target, callbackQueue queue: DispatchQueue? = .main, progress: ProgressBlock? = nil, completion: @escaping Completion) -> Cancellable {
//        return super.request(target, callbackQueue: queue, progress: progress, completion: { result in
//            switch result {
//            case let .success(moyaResponse):
//
//
//                if (moyaResponse.statusCode == 401) {
//                    if moyaResponse.request?.allHTTPHeaderFields?.index(forKey: "Authorization") != nil {
////                        let token = UserDefaults.standard.string(forKey: "refresh") ?? ""
////                        self.refreshTokenSyncRequest(refreshToken: token, urlString: BASE_URL+"/account/token-refresh/") {(code, response) in
////                            if (code == 200) {
////                                do {
////                                    let decoder = JSONDecoder.init()
//////                                    let r = try decoder.decode(Token.self, from: response!)
//////                                    UserDefaults.standard.set(r.access, forKey: "token")
//////                                    UserDefaults.standard.set(r.refresh, forKey: "refresh")
////                                } catch (let error) {
////                                    print(error)
////                                }
////
////                                let _ = self.requestNormal(target, callbackQueue: queue, progress: progress, completion: { result1 in
////                                    completion(result1)
////                                })
////                            }
////                        }
//                    }
//                }
//                else {
//                    completion(result)
//                }
//                        break
//            case let .failure(error):
//                print(error)
//                break
//            }
//            completion(result)
//        })
//
//    }
    
}

extension MyMoyaProvider {
    
//    func refreshTokenSyncRequest(refreshToken: String, urlString:String, completion: @escaping (Int, Data?) -> ()) {
//        let url = URL(string: urlString.trimmingCharacters(in: .whitespaces))
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        request.httpBody = try! JSONSerialization.data(withJSONObject: ["refresh": refreshToken])
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            guard let data = data, error == nil else {
//                completion(0, nil) // or return an error code
//                return
//            }
//
//            let httpStatus = response as? HTTPURLResponse
//            let httpStatusCode:Int = (httpStatus?.statusCode)!
//
//            completion(httpStatusCode, data)
//        }
//        task.resume()
//
//    }
    
}

//#27A249
//
//#09BCC4
//
//#EE4C4F
