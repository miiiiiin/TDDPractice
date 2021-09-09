//
//  ConverterTests.swift
//  NumeroTests
//
//  Created by Running Raccoon on 2021/09/09.
//  Copyright © 2021 Facebook. All rights reserved.
//

import XCTest
@testable import Numero

class ConverterTests: XCTestCase {
    
    var converter: Converter?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        converter = Converter()
    }
    
    func testConversionForOne() {
        let result = converter?.convert(1)
        XCTAssertEqual(result, "I", "I에 관한 convert 결과가 틀림")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
