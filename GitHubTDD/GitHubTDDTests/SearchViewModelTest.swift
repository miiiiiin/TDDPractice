//
//  SearchViewModelTest.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/22.
//

import RxSwift
import RxTest
import XCTest
import Cuckoo
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
    
    func testLoadingOnSuccess() {
        
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
            .next(0, true),
            .next(0, false)
        ])
        
        verify(service, times(1)).search(sortOption: any())
    }

    func testLoadingOnFailure() {
        
        service.setMocking(error: TestError.test)
        
        let isLoading = testScheduler.createObserver(Bool.self)
        viewModel.isLoading
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        viewModel.searchText.accept("test")
        testScheduler.createHotObservable([
            .next(0, ()),
            .next(50, ())
            ])
            .bind(to: viewModel.doSearch)
            .disposed(by: disposeBag)
        
        testScheduler.start()
        
        // Error가 발생하면 이벤트가 끊어지는지 체크
        XCTAssertEqual(isLoading.events, [
            .next(0, true),
            .next(0, false),
            .next(50, true),
            .next(50, false)
            ])
        
        verify(service, times(2)).search(sortOption: any())
    }
    
    func testSections() {
        
        let (data, _) = service.setMocking()
        let sections = testScheduler.createObserver([RepositorySection].self)
        
        viewModel.section
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        viewModel.searchText.accept("test")
        
        testScheduler.createHotObservable([
            .next(0, ())
        ])
        .bind(to: viewModel.doSearch)
        .disposed(by: disposeBag)
        
        testScheduler.start()

        let expect = [RepositorySection(header: "test", items: data.items)]

//        XCTAssertEqual(sections.events, [
//            .next(0, expect)
//        ])
        
        verify(service, times(1)).search(sortOption: any())
        
    }
}

extension SearchedRepositories: Equatable {
    public static func == (lhs: SearchedRepositories, rhs: SearchedRepositories) -> Bool {
        return lhs.total_count == rhs.total_count && lhs.items == rhs.items
    }
}
