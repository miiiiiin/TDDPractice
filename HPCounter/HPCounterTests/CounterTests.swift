//
//  CounterTests.swift
//  HPCounterTests
//
//  Created by Running Raccoon on 2021/10/19.
//

import XCTest
import RxNimble
import RxTest
import RxSwift
@testable import HPCounter

class CounterTests: XCTestCase {
    
    var viewModel: CounterViewModel!
    var scheduler: TestScheduler!
    var output: CounterViewModel.Output!
    
    var disposeBag: DisposeBag!
    
    var plusSubject: PublishSubject<Void>!
    var subtractSubject: PublishSubject<Void>!

    override func setUp() {
        
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        plusSubject = PublishSubject<Void>()
        subtractSubject = PublishSubject<Void>()
        viewModel = CounterViewModel()
        output = viewModel.transform(input: CounterViewModel.Input(plusAction: plusSubject.asObservable(), subtractAction: subtractSubject.asObservable()))
    }

    func testCountedValue() {
        scheduler.createColdObservable([
            .next(10, ()),
            .next(20, ()),
            .next(30, ())
        ]).bind(to: plusSubject).disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(25, ())
        ]).bind(to: subtractSubject).disposed(by: disposeBag)
        
        
    }
}
