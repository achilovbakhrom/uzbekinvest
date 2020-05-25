//
//  Factory.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/18/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

protocol Factory {
    func reslove(_ type: Service.Type) -> Service
}
