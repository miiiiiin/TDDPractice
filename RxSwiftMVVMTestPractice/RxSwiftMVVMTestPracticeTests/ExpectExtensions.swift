//
//  ExpectExtensions.swift
//  RxSwiftMVVMTestPracticeTests
//
//  Created by Running Raccoon on 2021/09/28.
//

import Foundation
import RxSwift
import RxNimble
import RxTest
import Nimble

public extension Expectation where T: ObservableConvertibleType {
    
    internal func transform<U>(_ closure: @escaping (T?) throws -> U?) -> Expectation<U> {
        let expression = expression.cast(closure)
        return Expectation<U>(expression: expression)
    }
    
    func events(scheduler: TestScheduler,
                disposeBag: DisposeBag,
                startAt initialTime: Int = 0) -> Expectation<[Recorded<Event<T.Element>>]> {
        return transform { source in
            let results = scheduler.createObserver(T.Element.self)
            scheduler.scheduleAt(initialTime) {
                source?.asObservable()
                    .subscribe(results)
                    .disposed(by: disposeBag)
            }
            scheduler.start()
            
            print("get event: \(results.events)")
            return results.events
        }
    }
}

