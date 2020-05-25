//
//  Container.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

struct Container {
    
    let factories: [BasicFactory]
    
    init() {
        factories = []
    }
    
    func resolve<T: Service>(_ type: T.Type) -> T? {
        for f in self.factories {
            return f.reslove(type) as? T
        }
        return nil;
    }
    
}
