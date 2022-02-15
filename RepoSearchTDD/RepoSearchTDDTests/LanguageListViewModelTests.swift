//
//  LanguageListViewModelTests.swift
//  RepoSearchTDDTests
//
//  Created by Running Raccoon on 2022/02/15.
//

import XCTest
import RxTest
import RxSwift
@testable import RepoSearchTDD

class LanguageListViewModelTests: XCTestCase {

    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var githubService: GithubServiceMock!
    var viewModel: LanguageListViewModel!

    override func setUp() {
        super.setUp()

        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        githubService = GithubServiceMock()
        viewModel = LanguageListViewModel(githubService: githubService)
    }
    
    func test_SelectLanguage_EmitsDidSelectLanguage() {
        testScheduler.createHotObservable([.next(300, "Java")])
            .bind(to: viewModel.selectLanguage)
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModel.didSelectLanguage }
        XCTAssertEqual(result.events, [.next(300, "Java")])
        
    }
    
    func test_Cancel_EmitsDidCancel() {
        testScheduler.createHotObservable([.next(300, ())])
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModel.didCancel.map { true } }
        XCTAssertEqual(result.events, [.next(300, true)])
    }
    
    func test_Languages_EmitsResultOfRequest() {
        githubService.languageListReturnValue = .just(["Swift", "Python"])
        viewModel = LanguageListViewModel(githubService: githubService)
        
        let result = testScheduler.start { self.viewModel.languages }
        
        XCTAssertEqual(result.events.count, 2)
        
        guard let languageResult = result.events.first?.value.element else {
             return XCTFail()
        }
        
        XCTAssertEqual(languageResult, ["Swift", "Java"])
    }
}
