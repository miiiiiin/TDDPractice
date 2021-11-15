//
//  SearchRepositoryViewControllerTests.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/15.
//

import XCTest
@testable import LetsGitHubSearchPractice

final class SearchRepositoryViewControllerTests: XCTestCase {

    
    func testSearchBar_whenSearchBarSearchButtonClicked_searchWithText() {
        // given
        
        let repositoryService = RepositoryServiceStub()
        let viewController = SearchRepositoryViewController()
        
        viewController.repositoryService = repositoryService
        _ = viewController.view
        
        // when
        
        let searchBar = viewController.searchController.searchBar
        searchBar.text = "ReactorKit"
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        
        // then
        
        XCTAssertEqual(repositoryService.searchParameters, "ReactorKit")
        
//        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 3)
//        let cell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
//        XCTAssertEqual(cell?.textLabel?.text, "ReactorKit")
    }
}