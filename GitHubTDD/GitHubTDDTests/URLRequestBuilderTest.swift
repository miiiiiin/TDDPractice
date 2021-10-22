//
//  URLRequestBuilderTest.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/22.
//

import XCTest
@testable import GitHubTDD

class URLRequestBuilderTest: XCTestCase {

    func testURLRequest() {
        let result = try! URLRequestBuilder
            .get(baseURL: "https://test.com")
            .path("/rra")
            .build()
        
        XCTAssertEqual(result.url!.absoluteString, "https://test.com/rra")
    }
    
    func testURLReqeustWithQueryItems() {
        let result = try! URLRequestBuilder
            .get(baseURL: "https://test.com")
            .path("/rra")
            .queryItems([URLQueryItem(name: "test", value: "tt")])
            .build()
        XCTAssertEqual(result.url!.absoluteString, "https://test.com/rra?test=tt")
    }
}
