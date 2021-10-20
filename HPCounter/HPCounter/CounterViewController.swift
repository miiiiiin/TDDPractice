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

    private lazy var input = CounterViewModel.Input(refresh: .just(()), plusAction: plusButton.rx.tap.asObservable(), subtractAction: subtractButton.rx.tap.asObservable())

    private lazy var output = viewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        output.countedValue.map { String($0) }.drive(counterLabel.rx.text).disposed(by: disposeBag)
    }
}
