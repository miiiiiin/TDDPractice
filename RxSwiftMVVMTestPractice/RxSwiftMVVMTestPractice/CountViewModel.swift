//
//  CountViewModel.swift
//  RxSwiftMVVMTestPractice
//
//  Created by Running Raccoon on 2021/09/28.
//

import Foundation
import RxSwift
import RxCocoa

class CountViewModel: ViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        var didTapButton: Observable<Void>
    }
    
    struct Output {
        var count: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let count = BehaviorRelay(value: 0)
        
        input.didTapButton.bind(onNext: { _ in
            count.accept(count.value + 1)
        })
        .disposed(by: disposeBag)
        
        return Output(count: count.asDriver(onErrorJustReturn: 0))
    }
}
