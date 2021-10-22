//
//  SearchViewModelTest.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/22.
//

import RxSwift
import RxTest
import XCTest
@testable import GitHubTDD

class SearchViewModelTest: XCTestCase {

    var viewModel: SearchViewModel!
    var service: MockGithubServiceType!
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        service = MockGithubServiceType()
        testScheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        viewModel = SearchViewModel(service: service, scheduler: TestRxScheduler(testScheduler))
        disposeBag = DisposeBag()
    }
    
    func testIsLoading() {
        
        service.setMocking()
        
        let isLoading = testScheduler.createObserver(Bool.self)
        
        viewModel.isLoading
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        testScheduler.createHotObservable([
            .next(0, "loading")
        ])
        .bind(to: viewModel.searchText)
        .disposed(by: disposeBag)
        
        testScheduler.start()
        
        XCTAssertEqual(isLoading.events, [
            .next(0, false)
//            ,
//            .next(1, true)
        ])
    }
}
