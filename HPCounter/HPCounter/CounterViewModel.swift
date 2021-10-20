//
//  CounterViewModel.swift
//  HPCounter
//
//  Created by Running Raccoon on 2021/10/19.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class CounterViewModel: ViewModelType {
    
    var provider = MoyaProvider<CounterAPI>()
    
    let disposeBag = DisposeBag()
    
    struct Input {
        var refresh: Observable<Void>
        var plusAction: Observable<Void>
        var subtractAction: Observable<Void>
    }
    
    struct Output {
        var countedValue: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let countedValue = BehaviorRelay(value: 0)
        
        let counterObesrvable = input.refresh
            .flatMapLatest { [provider] _ in
                return provider.rx.request(.init())
                    .map(CounterDataModel.self)
            }
//            .share()
        
        counterObesrvable.map { $0.counterDefaultValue }
            .subscribe(onNext: { defaultValue in
                print("defaultValue: \(defaultValue)")
                countedValue.accept(defaultValue)
            })
            .disposed(by: disposeBag)
        
        input.plusAction
            .skipUntil(counterObesrvable)
            .subscribe(onNext: { _ in
                countedValue.accept(countedValue.value + 1)
            })
            .disposed(by: disposeBag)
        
        input.subtractAction
            .skipUntil(counterObesrvable)
            .subscribe(onNext: { _ in
                countedValue.accept(countedValue.value - 1)
            })
            .disposed(by: disposeBag)
        
        return Output(countedValue: countedValue.asDriver(onErrorJustReturn: 0))
    }
}
