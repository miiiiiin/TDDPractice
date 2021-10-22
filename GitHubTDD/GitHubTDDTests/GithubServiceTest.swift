//
//  GithubServiceTest.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/07.
//

import XCTest
import RxSwift
import RxTest
import Foundation
@testable import GitHubTDD

class GithubServiceTest: XCTestCase {
    
    var service: GithubService!
    var requests: MockNetworkRequestProtocol!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        requests = MockNetworkRequestProtocol()
        service = GithubService(networkRequest: requests, scheduler: TestRxScheduler(scheduler))
    }
    
    func testSampleSuccess() {
        
        // MARK: - Set Mock -
        requests.setMocking(data: Fixture.Repositories.sampleData)
        
        let response = scheduler.createObserver(SearchedRepositories.self)
        
        service.search(sortOption: SearchOption(q: "", sort: "", order: ""))
            .asObservable()
            .subscribe(response)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
        
        XCTAssertEqual(response.events, [
            .next(0, Fixture.Repositories.sample),
            .completed(0)
        ])
    }
    
    

}
