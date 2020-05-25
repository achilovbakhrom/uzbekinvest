//
//  phoneNumberTest.swift
//  iosappTests
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import XCTest
@testable import iosapp

class phoneNumberTest: XCTestCase {
    
    let phoneNumber = "+998 94 444-44-441"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        print(phoneNumber.digits)
        XCTAssert(phoneNumber.digits.starts(with: "9989") && phoneNumber.digits.count == 12)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}

