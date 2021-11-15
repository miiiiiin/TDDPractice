//
//  RepositoryServiceTests.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/12.
//

import XCTest
import Alamofire
@testable import LetsGitHubSearchPractice

final class RepositoryServiceTests: XCTestCase {
    
    func testSearch_api_with_Parameters() {
        // given
        
        let sessionManager = SessionManagerStub()
        let service = RepositoryService(session: sessionManager)
        
//        let expectation = XCTestExpectation()
//        XCTWaiter().wait(for: [expectation], timeout: 10)
        
        // when
        
        service.search(keyword: "RxSwift", completionHandler: { _ in })
        
        // then
        
        let expectedURL = "https://api.github.com/search/repositories"
        let actualURL = try? sessionManager.requestParameters?.url.asURL().absoluteString
        XCTAssertEqual(actualURL, expectedURL)
        
        let expectedMethod = HTTPMethod.get
        let actualMethod = sessionManager.requestParameters?.method
        XCTAssertEqual(actualMethod, expectedMethod)
        
        
        let expectedParameters = ["q": "RxSwift"]
        let actualParameters = sessionManager.requestParameters?.parameters as? [String: String]
        XCTAssertEqual(actualParameters, expectedParameters)
    }
}
