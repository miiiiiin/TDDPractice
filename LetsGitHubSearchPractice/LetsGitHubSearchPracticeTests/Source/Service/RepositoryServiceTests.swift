//
//  RepositoryServiceTests.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/12.
//

import XCTest
@testable import LetsGitHubSearchPractice

final class RepositoryServiceTests: XCTestCase {
    
    func testSearch_includesSearchResult() {
        // given
        let expectation = XCTestExpectation()
        XCTWaiter().wait(for: [expectation], timeout: 10)
        
        // when
        
        RepositoryService.search(keyword: "RxSwift") { result in
            expectation.fulfill()
            XCTAssertEqual(try? (result.get().totalCount > 0) , true)
            XCTAssertEqual(try? (result.get().items.contains(where: { $0.name == "RxSwift" })) , true)
        }
    }
}
