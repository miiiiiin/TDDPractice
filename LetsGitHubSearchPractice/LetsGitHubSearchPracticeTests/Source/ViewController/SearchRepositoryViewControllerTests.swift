//
//  SearchRepositoryViewControllerTests.swift
//  LetsGitHubSearchPracticeTests
//
//  Created by Running Raccoon on 2021/11/15.
//

import XCTest
@testable import LetsGitHubSearchPractice

final class SearchRepositoryViewControllerTests: XCTestCase {
    
    private var repositoryService: RepositoryServiceStub!
    private var viewController: SearchRepositoryViewController!
    
    override func setUp() {
        self.repositoryService = RepositoryServiceStub()
        
        viewController = SearchRepositoryViewController()
        viewController.repositoryService = repositoryService
        _ = viewController.view
    }
    
    func testSearchBar_whenSearchBarSearchButtonClicked_searchWithText() {
        
        // when
        
        let searchBar = viewController.searchController.searchBar
        searchBar.text = "ReactorKit"
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        
        // then
        
        XCTAssertEqual(repositoryService.searchParameters?.keyword, "ReactorKit")
        
        //        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 3)
        //        let cell = viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        //        XCTAssertEqual(cell?.textLabel?.text, "ReactorKit")
    }
    
    func testTableView_isHidden_whileSearching() {
        // when
        let searchBar = viewController.searchController.searchBar
        searchBar.text = "ReactorKit"
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        
        // then
        XCTAssertTrue(viewController.tableView.isHidden)
    }
    
    func testTableView_isVisible_afterSearching() {
        // when
        let searchBar = viewController.searchController.searchBar
        searchBar.text = "ReactorKit"
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        repositoryService.searchParameters?.completionHandler(.failure(TestError().asAFError(orFailWith: "")))
        
        // then
        XCTAssertTrue(viewController.tableView.isHidden)
    }
    
    
    func testTableView_configureRepositoryCell_afterSearching() {
        // given
        let searchBar = self.viewController.searchController.searchBar
        searchBar.text = "ReactorKit"
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        
        // when
        let repositories = [
            Repository(name: "ReactorKit1"),
            Repository(name: "ReactorKit2"),
            Repository(name: "ReactorKit3"),
        ]
        let searchResult = RepoSearchResult(totalCount: 3, items: repositories)
        self.repositoryService.searchParameters?.completionHandler(.success(searchResult))
        
        // then
        let numberOfRows = self.viewController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 3)
        
        let cell0 = self.viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell0?.textLabel?.text, "ReactorKit1")
        
        let cell1 = self.viewController.tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell1?.textLabel?.text, "ReactorKit2")
        
        let cell2 = self.viewController.tableView.cellForRow(at: IndexPath(row: 2, section: 0))
        XCTAssertEqual(cell2?.textLabel?.text, "ReactorKit3")
    }
    
}
