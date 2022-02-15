//
//  RepositoryListViewModelTests.swift
//  RepoSearchTDDTests
//
//  Created by Running Raccoon on 2022/02/15.
//


import RxTest
@testable import RepoSearchTDD
import XCTest
import RxSwift

class RepositoryListViewModelTests: XCTestCase {

    let testRepository = Repository(fullName: "Full Name",
                                    description: "Description",
                                    starsCount: 3,
                                    url: "https://www.apple.com")
    
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var githubService: GithubServiceMock!
    var viewModel: RepositoryListViewModel!
    
    override func setUp() {
        super.setUp()
        
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        githubService = GithubServiceMock()
        viewModel = RepositoryListViewModel(initialLanguage: "Swift", githubService: githubService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_InitWithInitialLanguage_EmitsValidTitle() {
        viewModel = RepositoryListViewModel(initialLanguage: "Swift", githubService: githubService)
        let result = testScheduler.start { self.viewModel.title }
        XCTAssertEqual(result.events, [Recorded.next(200, "Swift")])
        
        
    }
    
    func test_InitWithInitialLanguage_SendsValidRequest() {
        viewModel = RepositoryListViewModel(initialLanguage: "Swift", githubService: githubService)
        
        testScheduler.createHotObservable([.next(300, ())])
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModel.repositories }
     
        XCTAssertEqual(result.events.count, 0)
        XCTAssertEqual("Swift", githubService.repositoriesLanguageArgument)
    }
    
    
    func test_Repositories_ReturnsValidViewModels() {
        let testRepository = Repository(fullName: "Full Name", description: "description", starsCount: 3, url: "https://www.apple.com")
        
        githubService.repositoriesReturnValue = .just([testRepository])
        
        testScheduler.createHotObservable([.next(300, ())])
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModel.repositories }
        XCTAssertEqual(result.events.count, 1)
        
        guard let repositoryViewModel = result.events.first?.value.element?.first else { return XCTFail() }
        
        XCTAssertEqual(repositoryViewModel.name, "Full Name")
    }
    
}
