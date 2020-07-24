//
//  NetworkManager.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

let serverTrustPolicies: [String: ServerTrustPolicy] = [
    "http://62.209.128.56": .disableEvaluation
]

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    
    public init() {
        super.init(policies: serverTrustPolicies)
    }
    
}

struct NetworkManager {
    
    var tokenFactory: TokenFactory
    var authPlugin: AuthPlugin
    var auth: MyMoyaProvider<AuthProvider>
    var insurance: MyMoyaProvider<InsuranceProvider>
    var user: MyMoyaProvider<UserProvider>
    var incident: MyMoyaProvider<IncidentsProvider>
    var callRequest: MyMoyaProvider<CallRequestProvider>
    var exportOperation: MyMoyaProvider<ExportOperationsProvider>
    var insuranceReminder: MyMoyaProvider<InsuranceReminderProvider>
    var regions: MyMoyaProvider<RegionsProvider>
    var others: MyMoyaProvider<OthersProvider>
    var orders: MyMoyaProvider<OrderProvider>
    var transport: MyMoyaProvider<TransportProvider>
    var product: MyMoyaProvider<ProductProvider>
    var networkLoggingPlugin: NetworkLoggerPlugin
    
    init(tokenFactory: TokenFactory) {
        let manager = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )
        
        self.tokenFactory = tokenFactory
        authPlugin = AuthPlugin(tokenClosure: { () -> String? in tokenFactory.getToken() })
        networkLoggingPlugin = NetworkLoggerPlugin()
        
        auth = MyMoyaProvider(manager: manager, plugins: [networkLoggingPlugin])
        insurance = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        user = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        incident = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        callRequest = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        exportOperation = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        insuranceReminder = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        regions = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        others = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        orders = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        transport = MyMoyaProvider(manager: manager, plugins: [authPlugin, networkLoggingPlugin])
        product = MyMoyaProvider(manager: manager, plugins: [networkLoggingPlugin])
    }
}

