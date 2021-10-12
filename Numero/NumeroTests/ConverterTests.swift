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
    
    func testConversionForTwo() {
        let result = converter?.convert(2)
        XCTAssertEqual(result, "II", "II에 관한 convert 결과가 틀림")
    }
    
    func testConversionFive() {
        let result = converter?.convert(5)
        XCTAssertEqual(result, "V", "5에 관한 convert 결과가 틀림")
    }
    
    func testConversionSix() {
        let result = converter?.convert(6)
        XCTAssertEqual(result, "VI", "6에 관한 convert 결과가 틀림")
    }
    
    func testConversionSeven() {
        let result = converter?.convert(7)
        XCTAssertEqual(result, "?", "7에 관한 convert 결과가 틀림")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called a  fter the invocation of each test method in the class.
    }    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
