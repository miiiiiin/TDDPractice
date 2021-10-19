//
//  CounterViewModel.swift
//  HPCounter
//
//  Created by Running Raccoon on 2021/10/19.
//

import Foundation
import RxSwift
import RxCocoa

class CounterViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        var plusAction: Observable<Void>
        var subtractAction: Observable<Void>
    }
    
    struct Output {
        var countedValue: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let countedValue = BehaviorRelay(value: 0)
        
        input.plusAction
            .subscribe(onNext: { _ in
                countedValue.accept(countedValue.value + 1)
            })
            .disposed(by: disposeBag)
        
        input.subtractAction
            .subscribe(onNext: { _ in
                countedValue.accept(countedValue.value - 1)
            })
            .disposed(by: disposeBag)
        
        return Output(countedValue: countedValue.asDriver(onErrorJustReturn: 0))
    }
}
