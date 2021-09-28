//
//  CustomTest.swift
//  RxSwiftMVVMTestPracticeTests
//
//  Created by Running Raccoon on 2021/09/28.
//

import XCTest
import RxSwift
import RxCocoa
import RxNimble
import Nimble
import RxTest
@testable import RxSwiftMVVMTestPractice

class CustomTest: XCTestCase {
    
    var disposeBag: DisposeBag!
    var viewModel = CountViewModel()
    var scheduler: TestScheduler!
    var didTapButton: PublishSubject<Void>!
    lazy var output = viewModel.transform(input: .init(didTapButton: didTapButton.asObservable()))

    
    override func setUp() {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        viewModel = CountViewModel()
        didTapButton = PublishSubject<Void>()
    }
    
    func testAddCount() throws {
     
        // When
        scheduler.createColdObservable([
            .next(1, ()),
            .next(10, ()),
            .next(30, ()),
        ])
        .bind(to: didTapButton).disposed(by: disposeBag)
        
        // Then
        expect(self.output.count).events(scheduler: scheduler, disposeBag: disposeBag).to(equal([
            .next(0, 0),
            .next(1, 1),
            .next(10, 2),
            .next(30, 3),
        ]))
    }
    
    
//    func testAddCount() throws {
//        // When
//        scheduler.createColdObservable([
//            .next(1, ()),
//            .next(10, ()),
//            .next(30, ()),
//            ]).bind(to: didTapBtnToggle).disposed(by: bag)
//
//        // Then
//        expect(self.output.toggleCount).events(scheduler: scheduler, disposeBag: bag).to(equal([
//            .next(0, 0),
//            .next(1, 1),
//            .next(10, 2),
//            .next(30, 3),
//        ]))
//    }
    
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
