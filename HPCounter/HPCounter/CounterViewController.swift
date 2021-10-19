//
//  CounterViewController.swift
//  HPCounter
//
//  Created by Running Raccoon on 2021/10/19.
//

import Foundation
import UIKit
import RxSwift

class CounterViewController: UIViewController {
    
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var subtractButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    
    var viewModel = CounterViewModel()
    let disposeBag = DisposeBag()

    private lazy var input = CounterViewModel.Input(plusAction: plusButton.rx.tap.asObservable(), subtractAction: subtractButton.rx.tap.asObservable())

    private lazy var output = viewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
//        var viewModel: CounterViewModel!
//        var output: CounterViewModel.Output!
//        var scheduler: TestScheduler!
//        var disposeBag: DisposeBag!
//
//        var plusSubject: PublishSubject<Void>!
//        var subtractSubject: PublishSubject<Void>!
        
//        scheduler.createColdObservable(
//                        [
//                                .next(10, ()),
//                    .next(20, ()),
//                    .next(30, ())
//                ]
//            ).bind(to: plusSubject).disposed(by: disposeBag)
//
//            scheduler.createColdObservable(
//                [
//                    .next(25, ())
//                ]
//            ).bind(to: subtractSubject).disposed(by: disposeBag)
//
//            expect(self.output.countedValue).events(scheduler: scheduler, disposeBag: disposeBag).to(equal(
//                [
//                    .next(0, 0),
//                    .next(10, 1),
//                    .next(20, 2),
//                    .next(25, 1),
//                    .next(30, 2)
//                ]
//            ))
        
    }

    private func bindViewModel() {
        output.countedValue.map { String($0) }.drive(counterLabel.rx.text).disposed(by: disposeBag)
    }
}
