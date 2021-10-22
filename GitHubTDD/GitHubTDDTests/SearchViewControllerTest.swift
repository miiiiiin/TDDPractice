//
//  SearchViewControllerTest.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/07.
//

import XCTest
import Foundation
import RxSwift
import RxTest
import Cuckoo
@testable import GitHubTDD

class SearchViewControllerTest: XCTestCase {
    
    var viewController: SearchViewController!
    var viewModel: SearchViewModel!
    var service: MockGithubServiceType!
    var testSchduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        service = MockGithubServiceType()
        testSchduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        viewModel = SearchViewModel(service: service, scheduler: TestRxScheduler(testSchduler))
        viewController = SearchViewController()
        disposeBag = DisposeBag()
        
        // trigger viewDidLoad
        _ = viewController.view
    }

    func testPresentCell() {
        let (data, _) = service.setMocking()
        viewModel.searchText.accept("test")
        viewModel.doSearch.accept(())
        testSchduler.start()
        let cell = viewController.dataSource.collectionView(viewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as! RepositoryCell
        XCTAssertEqual(cell.repositoryNameLabel.text, data.items.first!.name)        
    }
}
