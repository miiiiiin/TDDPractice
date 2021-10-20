//
//  CounterTests.swift
//  HPCounterTests
//
//  Created by Running Raccoon on 2021/10/19.
//

import XCTest
import Nimble
import RxNimble
import RxTest
import RxSwift
import Moya
@testable import HPCounter

class CounterTests: XCTestCase {
    
    var viewModel: CounterViewModel!
    var scheduler: TestScheduler!
    var output: CounterViewModel.Output!
    
    var disposeBag: DisposeBag!
    
    var refreshSubject: PublishSubject<Void>!
    var plusSubject: PublishSubject<Void>!
    var subtractSubject: PublishSubject<Void>!

    override func setUp() {
        
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        refreshSubject = PublishSubject<Void>()
        plusSubject = PublishSubject<Void>()
        subtractSubject = PublishSubject<Void>()
        viewModel = CounterViewModel()
        
        // viewModel moya provider 초기화
        viewModel.provider = MoyaProvider<CounterAPI>(endpointClosure: Endpoint.succeedEndpointClosure(CounterAPI.self, with: CounterDataModel(counterDefaultValue: 5)), stubClosure: MoyaProvider.immediatelyStub)
        
        output = viewModel.transform(input: CounterViewModel.Input(refresh: .just(()), plusAction: plusSubject.asObservable(), subtractAction: subtractSubject.asObservable()))
    }

    func testCountedValue() {
        
        // refresh 기본값 5인 상황
        scheduler.createColdObservable([
            .next(0, ())
        ])
        .bind(to: refreshSubject).disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(10, ()),
            .next(20, ()),
            .next(30, ())
        ]).bind(to: plusSubject).disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(25, ())
        ]).bind(to: subtractSubject).disposed(by: disposeBag)

        expect(self.output.countedValue).events(scheduler: scheduler, disposeBag: disposeBag)
            .to(equal([
//                .next(0, 0),
//                .next(10, 1),
//                .next(20, 2),
//                .next(25, 1),
//                .next(30, 2)
                .next(0, 5),
                .next(10, 6),
                .next(20, 7),
                .next(25, 6),
                .next(30, 7)
            ]
        ))
    }
}
