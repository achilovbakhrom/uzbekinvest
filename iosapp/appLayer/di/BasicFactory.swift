//
//  BasicFactory.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

class BasicFactory: Factory {
    
    let resolver: Resolver;
    
    init(resolver: Resolver) {
        self.resolver = resolver;
    }
    
    func reslove(_ type: Service.Type) -> Service {
        return resolver.resolve(type);
    }
    
    
}
